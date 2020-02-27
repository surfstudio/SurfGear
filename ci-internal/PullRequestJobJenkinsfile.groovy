@Library('surf-lib@version-2.0.0-SNAPSHOT')
// https://bitbucket.org/surfstudio/jenkins-pipeline-lib/

import ru.surfstudio.ci.*
import ru.surfstudio.ci.pipeline.empty.EmptyScmPipeline
import ru.surfstudio.ci.pipeline.pr.PrPipeline
import ru.surfstudio.ci.stage.SimpleStage
import ru.surfstudio.ci.stage.StageStrategy

import static ru.surfstudio.ci.CommonUtil.extractValueFromEnvOrParamsAndRun

//Pipeline for check prs

// Stage names
def PRE_MERGE = 'PreMerge'
def GET_DEPENDENCIES = 'Getting dependencies'
def FIND_CHANGED = 'Find changed'
def CHECK_STABLE_MODULES_NOT_CHANGED = 'Check Stable Modules Not Changed'
def CHECK_MODULES_IN_DEPENDENCY_TREE_OF_STABLE_MODULE_ALSO_STABLE = 'Check dependencies of stable element also stable'
def CHECK_UNSTABLE_MODULES_DO_NOT_BECAME_STABLE = 'Check Unstable Modules Do Not Became Stable'
def CHECK_RELEASE_NOTES_VALID = 'Check Release Notes Valid'
def WRITE_RELEASE_NOTE = 'Write Release Notes'
def CHECK_LINT = 'Check Lint'
def CHECK_LICENSE = 'Check license'
def CHECK_OPENSOURCE_PUBLISH = 'Check publish for OpenSource modules'
def CHECKS_RESULT = 'All Checks Result'

def UNIT_TEST = 'Unit Test'
def BUILD = 'Build'

def CLEAR_CHANGED = 'Clear changed'

// git variables
def sourceBranch = ""
def destinationBranch = ""
def authorUsername = ""
def targetBranchChanged = false
def lastDestinationBranchCommitHash = ""

//parameters
final String SOURCE_BRANCH_PARAMETER = 'sourceBranch'
final String DESTINATION_BRANCH_PARAMETER = 'destinationBranch'
final String AUTHOR_USERNAME_PARAMETER = 'authorUsername'
final String TARGET_BRANCH_CHANGED_PARAMETER = 'targetBranchChanged'

// Other config
final String TEMP_FOLDER_NAME = "temp"

def stagesForProjectMode = [
        PRE_MERGE,
        GET_DEPENDENCIES,
        FIND_CHANGED,
        BUILD,
        UNIT_TEST
]

def stagesForTargetBranchChangedMode = [
        PRE_MERGE
]

def stagesForReleaseMode = [
        PRE_MERGE,
        GET_DEPENDENCIES,
        FIND_CHANGED,
        CHECK_STABLE_MODULES_NOT_CHANGED,
        CHECK_MODULES_IN_DEPENDENCY_TREE_OF_STABLE_MODULE_ALSO_STABLE,
        CHECK_LICENSE,
        CHECK_LINT,
        CHECK_RELEASE_NOTES_VALID,
        WRITE_RELEASE_NOTE,
        CHECK_OPENSOURCE_PUBLISH,
        CHECKS_RESULT,
        BUILD,
        UNIT_TEST,
]
def stagesForDevMode = [
        PRE_MERGE,
        GET_DEPENDENCIES,
        FIND_CHANGED,
        CHECK_STABLE_MODULES_NOT_CHANGED,
        CHECK_LICENSE,
        CHECK_LINT,
        BUILD,
        UNIT_TEST,
]

//init
def script = this
def pipeline = new EmptyScmPipeline(script)

pipeline.init()

//configuration
pipeline.propertiesProvider = { PrPipeline.properties(pipeline) }

pipeline.preExecuteStageBody = { stage ->
    if (stage.name != PRE_MERGE) RepositoryUtil.notifyBitbucketAboutStageStart(script, pipeline.repoUrl, stage.name)
}
pipeline.postExecuteStageBody = { stage ->
    RepositoryUtil.notifyBitbucketAboutStageFinish(script, pipeline.repoUrl, stage.name, stage.result)
}

pipeline.initializeBody = {
    CommonUtil.printInitialStageStrategies(pipeline)


    //если триггером был webhook параметры устанавливаются как env, если запустили вручную, то устанавливается как params
    extractValueFromEnvOrParamsAndRun(script, SOURCE_BRANCH_PARAMETER) {
        value -> sourceBranch = value
    }
    extractValueFromEnvOrParamsAndRun(script, DESTINATION_BRANCH_PARAMETER) {
        value -> destinationBranch = value
    }
    extractValueFromEnvOrParamsAndRun(script, AUTHOR_USERNAME_PARAMETER) {
        value -> authorUsername = value
    }
    extractValueFromEnvOrParamsAndRun(script, TARGET_BRANCH_CHANGED_PARAMETER) {
        value -> targetBranchChanged = Boolean.valueOf(value)
    }

    configureStageSkipping(
            script,
            pipeline,
            targetBranchChanged,
            stagesForTargetBranchChangedMode,
            "Build triggered by target branch changes, run only ${stagesForTargetBranchChangedMode} stages"
    )

    configureStageSkipping(
            script,
            pipeline,
            isSourceBranchRelease(sourceBranch),
            stagesForReleaseMode,
            "Build triggered by release source branch, run only ${stagesForReleaseMode} stages"
    )

    configureStageSkipping(
            script,
            pipeline,
            isDestinationBranchProjectSnapshot(destinationBranch),
            stagesForProjectMode,
            "Build triggered by project destination branch, run only ${stagesForProjectMode} stages"
    )

    configureStageSkipping(
            script,
            pipeline,
            isDestinationBranchDev(destinationBranch),
            stagesForDevMode,
            "Build triggered by dev destination branch, run only ${stagesForDevMode} stages"
    )

    def buildDescription = targetBranchChanged ?
            "$sourceBranch to $destinationBranch: target branch changed" :
            "$sourceBranch to $destinationBranch"

    CommonUtil.setBuildDescription(script, buildDescription)
    CommonUtil.abortDuplicateBuildsWithDescription(script, AbortDuplicateStrategy.ANOTHER, buildDescription)
}

pipeline.stages = [
        pipeline.stage(PRE_MERGE) {
            CommonUtil.safe(script) {
                script.sh "git reset --merge" //revert previous failed merge
            }
            script.git(
                    url: pipeline.repoUrl,
                    credentialsId: pipeline.repoCredentialsId,
                    branch: destinationBranch
            )

            lastDestinationBranchCommitHash = RepositoryUtil.getCurrentCommitHash(script)

            script.sh "git checkout origin/$sourceBranch"

            RepositoryUtil.saveCurrentGitCommitHash(script)

            //local merge with destination
            script.sh "git merge origin/$destinationBranch --no-ff"
        },

        pipeline.stage(GET_DEPENDENCIES) {
            script.sh "cd ci/ && pub get"
        },

        pipeline.stage(FIND_CHANGED) {
            script.sh "./ci/runner/find_changed_modules --target=${destinationBranch}"
        },

        pipeline.stage(CHECK_STABLE_MODULES_NOT_CHANGED, StageStrategy.UNSTABLE_WHEN_STAGE_ERROR) {
            script.sh("./ci/runner/check_stable_modules_not_changed")
        },

        pipeline.stage(CHECK_UNSTABLE_MODULES_DO_NOT_BECAME_STABLE, StageStrategy.UNSTABLE_WHEN_STAGE_ERROR) {
            script.sh("./ci/runner/check_stability_not_changed")
        },

        pipeline.stage(CHECK_MODULES_IN_DEPENDENCY_TREE_OF_STABLE_MODULE_ALSO_STABLE, StageStrategy.UNSTABLE_WHEN_STAGE_ERROR) {
            script.sh("./ci/runner/check_dependencies_stable")
        },

        pipeline.stage(CHECK_RELEASE_NOTES_VALID, StageStrategy.UNSTABLE_WHEN_STAGE_ERROR) {
            script.sh("./ci/runner/check_version_in_release_note")
            script.sh("./ci/runner/check_cyrillic_in_changelog")
        },

        pipeline.stage(WRITE_RELEASE_NOTE, StageStrategy.UNSTABLE_WHEN_STAGE_ERROR) {
            script.sh("./ci/runner/write_release_note")
        },

        pipeline.stage(CHECKS_RESULT) {
            script.sh "rm -rf $TEMP_FOLDER_NAME"
            def checksPassed = true
            [
                    CHECK_STABLE_MODULES_NOT_CHANGED,
                    CHECK_UNSTABLE_MODULES_DO_NOT_BECAME_STABLE,
                    CHECK_MODULES_IN_DEPENDENCY_TREE_OF_STABLE_MODULE_ALSO_STABLE,
                    // TODO: раскоментировать после правок модулей
//                    CHECK_RELEASE_NOTES_VALID,
//                    WRITE_RELEASE_NOTE
            ].each { stageName ->
                def stageResult = pipeline.getStage(stageName).result
                checksPassed = checksPassed && (stageResult == Result.SUCCESS || stageResult == Result.NOT_BUILT)

                if (!checksPassed) {
                    script.echo "Stage '${stageName}' ${stageResult}"
                }
            }

            if (!checksPassed) {
                throw script.error("Checks Failed, see reason above ^^^")
            }
        },

        pipeline.stage(BUILD) {
            script.sh("./ci/runner/build")
        },

        pipeline.stage(UNIT_TEST) {
            script.sh("./ci/runner/run_tests")
        },

        pipeline.stage(CLEAR_CHANGED) {
            script.sh "./ci/runner/clear_changed"
        },
]
pipeline.finalizeBody = {
    if (pipeline.jobResult != Result.SUCCESS && pipeline.jobResult != Result.ABORTED) {
        def unsuccessReasons = CommonUtil.unsuccessReasonsToString(pipeline.stages)
        def message = "Ветка ${sourceBranch} в состоянии ${pipeline.jobResult} из-за этапов: ${unsuccessReasons}; ${CommonUtil.getBuildUrlSlackLink(script)}"
        JarvisUtil.sendMessageToUser(script, message, authorUsername, "bitbucket")
    }
}

pipeline.run()


def configureStageSkipping(script, pipeline, isSkip, stageNames, message) {
    if (isSkip) {
        script.echo message
        pipeline.stages.each { stage ->
            if (!(stage instanceof SimpleStage)) {
                return
            }
            def executeStage = false
            stageNames.each { stageName ->
                executeStage = executeStage || (stageName == stage.getName())
            }
            if (!executeStage) {
                stage.strategy = StageStrategy.SKIP_STAGE
            }
        }
    }
}

def static isSourceBranchRelease(String sourceBranch) {
    return sourceBranch.startsWith("release")
}

def static isDestinationBranchProjectSnapshot(String destinationBranch) {
    return destinationBranch.startsWith("project-snapshot")
}

def static isDestinationBranchDev(String destinationBranch) {
    return destinationBranch.startsWith("feature-ci") //todo переименовать
}