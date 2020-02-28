@Library('surf-lib@version-2.0.0-SNAPSHOT') // https://bitbucket.org/surfstudio/jenkins-pipeline-lib/
import groovy.json.JsonSlurperClassic
import ru.surfstudio.ci.*
import ru.surfstudio.ci.pipeline.ScmPipeline
import ru.surfstudio.ci.pipeline.empty.EmptyScmPipeline
import ru.surfstudio.ci.stage.StageStrategy

//Pipeline for deploy snapshot artifacts

// Stage names
def CHECKOUT = 'Checkout'
def PREPARE_MIRRORING = 'Prepare Mirroring'
def MIRROR_COMPONENT = 'Mirror Component'
def ASSEMBLE_COMPONENT = 'Assemble Component'

//constants
def MIRROR_FOLDER = "_mirror"
def STANDARD_REPO_FOLDER = "temp"
def DEPTH_LIMIT = 100
def SEARCH_LIMIT = 100

//vars
def branchName = ""
def lastCommit = ""

//other config

def getTestInstrumentationRunnerName = { script, prefix ->
    def defaultInstrumentationRunnerGradleTaskName = "printTestInstrumentationRunnerName"
    return script.sh(
            returnStdout: true,
            script: "./gradlew :$prefix:$defaultInstrumentationRunnerGradleTaskName | tail -4 | head -1"
    )
}

//init
def script = this
def pipeline = new EmptyScmPipeline(script)

pipeline.init()

//configuration
pipeline.node = "android"
pipeline.propertiesProvider = { initProperties(pipeline) }

pipeline.preExecuteStageBody = { stage ->
    if (stage.name != CHECKOUT) RepositoryUtil.notifyBitbucketAboutStageStart(script, pipeline.repoUrl, stage.name)
}
pipeline.postExecuteStageBody = { stage ->
    if (stage.name != CHECKOUT) RepositoryUtil.notifyBitbucketAboutStageFinish(script, pipeline.repoUrl, stage.name, stage.result)
}

pipeline.initializeBody = {
    CommonUtil.printInitialStageStrategies(pipeline)

    script.echo "artifactory user: ${script.env.surf_maven_username}"

    //Выбираем значения веток из параметров, Установка их в параметры происходит
    // если триггером был webhook или если стартанули Job вручную
    //Используется имя branchName_0 из за особенностей jsonPath в GenericWebhook plugin
    CommonUtil.extractValueFromEnvOrParamsAndRun(script, 'branch') {
        value -> branchName = value
    }
    CommonUtil.extractValueFromEnvOrParamsAndRun(script, 'lastCommit') {
        value -> lastCommit = value
    }

    if (branchName.contains("origin/")) {
        branchName = branchName.replace("origin/", "")
    }

    def buildDescription = branchName
    CommonUtil.setBuildDescription(script, buildDescription)
    CommonUtil.abortDuplicateBuildsWithDescription(script, AbortDuplicateStrategy.ANOTHER, buildDescription)
}

pipeline.stages = [
        pipeline.stage(CHECKOUT) {
            script.git(
                    url: pipeline.repoUrl,
                    credentialsId: pipeline.repoCredentialsId
            )
            script.sh "git checkout -B $branchName origin/$branchName"

            script.echo "Checking $RepositoryUtil.SKIP_CI_LABEL1 label in last commit message for automatic builds"

            RepositoryUtil.saveCurrentGitCommitHash(script)
        },
        pipeline.stage(PREPARE_MIRRORING) {

            getСomponents(script).each { component ->
                if (component.mirror_repo != null && component.mirror_repo != "") {
                    pipeline.stages.add(
                            pipeline.stage("$MIRROR_COMPONENT : ${component.id}", StageStrategy.UNSTABLE_WHEN_STAGE_ERROR) {
                                script.sh "rm -rf $MIRROR_FOLDER"
                                script.sh "rm -rf $STANDARD_REPO_FOLDER"
                                script.sh "git clone --single-branch --branch $branchName ${pipeline.repoUrl} $STANDARD_REPO_FOLDER"

                                script.sh "git clone ${component.mirror_repo} $MIRROR_FOLDER"
                                withGithubCredentials(script) {
                                    script.sh "./gradlew deployToMirror -Pcomponent=${component.id} -Pcommit=$lastCommit " +
                                            "-PmirrorDir=$MIRROR_FOLDER -PdepthLimit=$DEPTH_LIMIT -PsearchLimit=$SEARCH_LIMIT"
                                }
                            }
                    )
                    pipeline.stages.add(
                            pipeline.stage("$ASSEMBLE_COMPONENT : ${component.id}", StageStrategy.UNSTABLE_WHEN_STAGE_ERROR) {
                                script.dir("$MIRROR_FOLDER") {
                                    script.sh "chmod +x gradlew && ./gradlew clean assemble"
                                }
                            }
                    )
                }
            }
        }
]

static void getСomponents(script){
    def content = script.readFile("buildSrc/components.json")
    return new JsonSlurperClassic().parseText(content)
}

pipeline.finalizeBody = {
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
    JarvisUtil.sendMessageToGroup(script, message, pipeline.repoUrl, "bitbucket", success)

}

pipeline.run()

// ============================================= ↓↓↓ JOB PROPERTIES CONFIGURATION ↓↓↓  ==========================================


def static List<Object> initProperties(ScmPipeline ctx) {
    def script = ctx.script
    return [
            initDiscarder(script),
            initParameters(script)
    ]
}

def static initDiscarder(script) {
    return script.buildDiscarder(
            script.logRotator(
                    artifactDaysToKeepStr: '3',
                    artifactNumToKeepStr: '10',
                    daysToKeepStr: '60',
                    numToKeepStr: '200')
    )
}

def static initParameters(script) {
    return script.parameters([
            script.string(
                    name: "branch",
                    description: 'Ветка с исходным кодом'
            ),
            script.string(
                    name: "lastCommit",
                    description: 'Коммит для зеркалирования'
            )
    ])
}

// ============================================= ↑↑↑  END JOB PROPERTIES CONFIGURATION ↑↑↑  ==========================================

// ============ Utils =================
def static withGithubCredentials(script, body) {
    script.withCredentials([
            script.usernamePassword(
                    credentialsId: "Github_Deploy_Credentials",
                    usernameVariable: 'surf_github_username',
                    passwordVariable: 'surf_github_password'
            )
    ]) {
        body()
    }
}