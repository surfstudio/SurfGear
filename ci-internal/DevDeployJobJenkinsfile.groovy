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

// Stage names

def CHECKOUT = 'Checkout'
def GET_DEPENDENCIES = 'Getting dependencies'
def FIND_CHANGED = 'Find changed'
def CHANGE_VIRSION = 'Change version'
def SAVE_LAST_GIT_HASH = 'Save last git hash'
def PUBLISHING_TO_PUB_DEV = 'Publishing to pub.dev'
def MIRRORING = 'Mirroring'
def PUSH_CHANGES = 'Push changes'
def CHECKS_RESULT = 'Checks Result'
def CLEAR_CHANGED = 'Clear changed'

//Pipeline on commit stable-branch

def mirrorRepoCredentialID = "76dbac13-e6ea-4ed0-a013-e06cad01be2d"

// const
def lastDeployHashFileName = './.last_deploy_hash'

//vars
def branchName = ""
def buildDescription = ""

//init
def script = this
def pipeline = new EmptyScmPipeline(script)

pipeline.init()

//configuration
pipeline.node = NodeProvider.getAndroidFlutterNode()
pipeline.propertiesProvider = { initProperties(pipeline) }

pipeline.preExecuteStageBody = { stage ->
    if (stage.name != CHECKOUT) RepositoryUtil.notifyBitbucketAboutStageStart(script, pipeline.repoUrl, stage.name)
}
pipeline.postExecuteStageBody = { stage ->
    if (stage.name != CHECKOUT) RepositoryUtil.notifyBitbucketAboutStageFinish(script, pipeline.repoUrl, stage.name, stage.result)
}

pipeline.initializeBody = {
    script.echo "initializeBody"

    CommonUtil.printInitialStageStrategies(pipeline)

    //Выбираем значения веток из параметров, Установка их в параметры происходит
    // если триггером был webhook или если стартанули Job вручную
    //Используется имя branchName_0 из за особенностей jsonPath в GenericWebhook plugin
    CommonUtil.extractValueFromEnvOrParamsAndRun(script, 'branchName_0') {
        value -> branchName = value
    }

    if (branchName.contains("origin/")) {
        branchName = branchName.replace("origin/", "")
    }

    buildDescription = branchName
    CommonUtil.setBuildDescription(script, buildDescription)

}

pipeline.stages = [
        // чекаут
        pipeline.stage(CHECKOUT) {
            script.git(
                    url: pipeline.repoUrl,
                    credentialsId: pipeline.repoCredentialsId
            )
            script.sh "git checkout -B $branchName origin/$branchName"

            script.echo "Checking $RepositoryUtil.SKIP_CI_LABEL1 label in last commit message for automatic builds"
            if (RepositoryUtil.isCurrentCommitMessageContainsSkipCiLabel(script) && !CommonUtil.isJobStartedByUser(script)) {
                throw new InterruptedException("Job aborted, because it triggered automatically and last commit message contains $RepositoryUtil.SKIP_CI_LABEL1 label")
            }
            CommonUtil.abortDuplicateBuildsWithDescription(script, AbortDuplicateStrategy.ANOTHER, buildDescription)

            RepositoryUtil.saveCurrentGitCommitHash(script)
        },

        // получение зависимостей
        pipeline.stage(GET_DEPENDENCIES) {
            script.sh "cd tools/ci/ && pub get"
        },

        // поиск изменившихся модулей
        pipeline.stage(FIND_CHANGED) {
            // взять хэш из файла и передать параметром
            script.sh "./tools/ci/runner/find_changed_modules --target=\$(cat ${lastDeployHashFileName})"
        },

        // изменения версии изменившихся модулей
        pipeline.stage(CHANGE_VIRSION) {
            script.echo "increment_dev_unstable_versions"
            script.sh "./tools/ci/runner/increment_dev_unstable_versions"
        },

        // паблишинга в паб
        pipeline.stage(PUBLISHING_TO_PUB_DEV) {
            script.echo "Publishing to pub.dev"
            script.withCredentials([
                    script.string(credentialsId: FLUTTER_PUB_ACCESS_TOKEN, variable: FLUTTER_PUB_ACCESS_TOKEN ),
                    script.string(credentialsId: FLUTTER_PUB_REFRESH_TOKEN, variable: FLUTTER_PUB_REFRESH_TOKEN ),
                    script.string(credentialsId: FLUTTER_PUB_TOKEN_ENDPOINT, variable: FLUTTER_PUB_TOKEN_ENDPOINT ),
                    script.string(credentialsId: FLUTTER_PUB_SCOPES, variable: FLUTTER_PUB_SCOPES ),
                    script.string(credentialsId: FLUTTER_PUB_EXPIRATION, variable: FLUTTER_PUB_EXPIRATION ),
            ]) {

                script.sh "rm -rf ~/.pub-cache/credentials.json"
                script.sh '''cat <<EOT >>  ~/.pub-cache/credentials.json
{"accessToken":"${FLUTTER_PUB_ACCESS_TOKEN}","refreshToken":"${FLUTTER_PUB_REFRESH_TOKEN}","tokenEndpoint":"${FLUTTER_PUB_TOKEN_ENDPOINT}","scopes":${FLUTTER_PUB_SCOPES},"expiration":${FLUTTER_PUB_EXPIRATION}}
EOT
    '''

                script.sh "./tools/ci/runner/publish_dev"
            }
        },

        // зеркалирования в отдельные репо
        pipeline.stage(MIRRORING) {
            script.echo "Mirroring"
            withCredentials([usernamePassword(credentialsId: mirrorRepoCredentialID, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                echo "credentialsId: $mirrorRepoCredentialID"
                sh "./tools/ci/runner/mirror_dev"
//                sh "git push --mirror https://${encodeUrl(USERNAME)}:${encodeUrl(PASSWORD)}@github.com/surfstudio/SurfGear.git"
            }
        },
        
        // сохранить хэш комита с версиями в файл
        pipeline.stage(SAVE_LAST_GIT_HASH) {
            script.echo "Save last git hash"
            script.sh "git rev-parse HEAD > $lastDeployHashFileName"
            script.sh "git add $lastDeployHashFileName"
            script.sh "git commit -m \"change last git hash\""
            script.sh "git push"
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
                script.error("Checks Failed")
            }
        },

        pipeline.stage(CLEAR_CHANGED) {
            script.sh "./tools/ci/runner/clear_changed"
        },
]

pipeline.finalizeBody = {
    script.echo "finalizeBody"

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

static List<Object> initProperties(ScmPipeline ctx) {
    def script = ctx.script
    return [
            initBuildDiscarder(script),
            initParameters(script)
    ]
}

def static initBuildDiscarder(script) {
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
                    name: "branchName_0",
                    description: 'Ветка с исходным кодом')
    ])
}