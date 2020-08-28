@Library('surf-lib@version-2.0.0-SNAPSHOT')
// https://bitbucket.org/surfstudio/jenkins-pipeline-lib/

import ru.surfstudio.ci.pipeline.empty.EmptyScmPipeline
import ru.surfstudio.ci.pipeline.ScmPipeline
import ru.surfstudio.ci.JarvisUtil
import ru.surfstudio.ci.CommonUtil
import ru.surfstudio.ci.RepositoryUtil
import ru.surfstudio.ci.Result
import ru.surfstudio.ci.NodeProvider
import ru.surfstudio.ci.AbortDuplicateStrategy

// repo urls
def mainRepoUrl = 'https://github.com/surfstudio/SurfGear.git'

//Pipeline on commit stable-branch
def mainRepoCredentialID = "76dbac13-e6ea-4ed0-a013-e06cad01be2d"

// Stage names
def CHECKOUT = 'Checkout'
def GET_CHANGES = 'Get package changes'
def CHECKS_RESULT = 'Checks Result'
def CLEAR_CHANGED = 'Clear changed'

//vars
def branchName = ''
def buildDescription = ''
def prefixName = ''

//init
def script = this
def pipeline = new EmptyScmPipeline(script)

pipeline.init()

//configuration
pipeline.node = NodeProvider.getAndroidFlutterNode()
pipeline.propertiesProvider = { initProperties(pipeline) }

pipeline.preExecuteStageBody = { stage ->
    if (stage.name != CHECKOUT) {
        RepositoryUtil.notifyBitbucketAboutStageStart(script, pipeline.repoUrl, stage.name)
    }
}
pipeline.postExecuteStageBody = { stage ->
    if (stage.name != CHECKOUT) {
        RepositoryUtil.notifyBitbucketAboutStageFinish(script, pipeline.repoUrl, stage.name, stage.result)
    }
}

pipeline.initializeBody = {
    script.echo 'initializeBody'

    CommonUtil.printInitialStageStrategies(pipeline)

    //Выбираем значения веток из параметров, Установка их в параметры происходит
    // если триггером был webhook или если стартанули Job вручную
    //Используется имя branchName_0 из за особенностей jsonPath в GenericWebhook plugin
    CommonUtil.extractValueFromEnvOrParamsAndRun(script, 'branchName_0') {
        value -> branchName = value
    }

    if (branchName.contains('origin/')) {
        branchName = branchName.replace('origin/', '')
    }

    if (branchName.contains('refs/heads/')) {
        branchName = branchName.replace('refs/heads/', '')
    }

    buildDescription = branchName
    CommonUtil.setBuildDescription(script, buildDescription)
}

pipeline.stages = [
        // чекаут
        pipeline.stage(CHECKOUT) {
            script.git(
                    url: mainRepoUrl,
                    credentialsId: mainRepoCredentialID
            )
            script.sh "git checkout -B $branchName origin/$branchName"

            script.echo "Checking $RepositoryUtil.SKIP_CI_LABEL1 label in last commit message for automatic builds"
            if (RepositoryUtil.isCurrentCommitMessageContainsSkipCiLabel(script) &&
                !CommonUtil.isJobStartedByUser(script)) {
                throw new InterruptedException(
                    "Job aborted, because it triggered automatically and last commit message contains $RepositoryUtil.SKIP_CI_LABEL1 label")
                }
            CommonUtil.abortDuplicateBuildsWithDescription(script, AbortDuplicateStrategy.ANOTHER, buildDescription)

            RepositoryUtil.saveCurrentGitCommitHash(script)
        },

        // получение изменений
        pipeline.stage(GET_CHANGES) {
            if (pipeline.repoUrl.contains('mwwm')) {
                prefixName = 'mwwm'
            }

            if (pipeline.repoUrl.contains('relation')) {
                prefixName = 'relation'
            }

            if (pipeline.repoUrl.contains('render_metrics')) {
                prefixName = 'render_metrics'
            }

            script.echo "get changes from $prefixName"

            script.echo "git subtree pull -m \"[skip ci] get changes from mirror\" --prefix=packages/$prefixName ${pipeline.repoUrl} dev"
            script.echo 'git push'
        },

        pipeline.stage(CHECKS_RESULT) {
            def checksPassed = true
            [
                MIRRORING
            ].each { stageName ->
                def stageResult = pipeline.getStage(stageName).result
                checksPassed = checksPassed && (stageResult == Result.SUCCESS || stageResult == Result.NOT_BUILT)
            }

            if (!checksPassed) {
                script.error('Checks Failed')
            }
        },

        pipeline.stage(CLEAR_CHANGED) {
            script.sh './tools/ci/runner/clear_changed'
        },
]

pipeline.finalizeBody = {
    script.echo 'finalizeBody'

    def jenkinsLink = CommonUtil.getBuildUrlSlackLink(script)
    def message
    def success = Result.SUCCESS == pipeline.jobResult
    def checkoutAborted = pipeline.getStage(CHECKOUT).result == Result.ABORTED
    if (!success && !checkoutAborted) {
        def unsuccessReasons = CommonUtil.unsuccessReasonsToString(pipeline.stages)
        message = "Deploy из ветки '${branchName}' не выполнен из-за этапов: ${unsuccessReasons}. ${jenkinsLink}"
    } else {
        message = "Deploy из ветки '${branchName}' успешно выполнен. ${jenkinsLink}"
    }
    JarvisUtil.sendMessageToGroup(script, message, pipeline.repoUrl, 'bitbucket', success)
}

pipeline.run()

static List<Object> initProperties(ScmPipeline ctx) {
    def script = ctx.script
    return [
            initBuildDiscarder(script),
            initParameters(script)
    ]
}

static initBuildDiscarder(script) {
    return script.buildDiscarder(
            script.logRotator(
                    artifactDaysToKeepStr: '3',
                    artifactNumToKeepStr: '10',
                    daysToKeepStr: '60',
                    numToKeepStr: '200')
    )
}

static initParameters(script) {
    return script.parameters([
            script.string(
                    name: 'branchName_0',
                    description: 'Ветка с исходным кодом')
    ])
}
