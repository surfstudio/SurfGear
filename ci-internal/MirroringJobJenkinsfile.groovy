@Library('surf-lib@version-3.0.0-SNAPSHOT')
// https://bitbucket.org/surfstudio/jenkins-pipeline-lib/
import ru.surfstudio.ci.pipeline.empty.EmptyScmPipeline
import ru.surfstudio.ci.stage.StageStrategy
import ru.surfstudio.ci.CommonUtil
import ru.surfstudio.ci.JarvisUtil
import ru.surfstudio.ci.Result
import ru.surfstudio.ci.NodeProvider
import java.net.URLEncoder

def encodeUrl(string) {
    URLEncoder.encode(string, "UTF-8")
}

//init
def pipeline = new EmptyScmPipeline(this)

//configuration
def mirrorRepoCredentialID = "76dbac13-e6ea-4ed0-a013-e06cad01be2d"

pipeline.node = NodeProvider.getAndroidFlutterNode()

pipeline.propertiesProvider = {
    return [
            pipelineTriggers([
                    GenericTrigger(),
                    pollSCM('')
            ])
    ]
}

//stages
pipeline.stages = [
        pipeline.stage("Clone", StageStrategy.FAIL_WHEN_STAGE_ERROR) {
            sh "rm -rf flutter-standard.git"
            withCredentials([usernamePassword(credentialsId: pipeline.repoCredentialsId, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                echo "credentialsId: $pipeline.repoCredentialsId"
                sh "git clone --mirror https://${encodeUrl(USERNAME)}:${encodeUrl(PASSWORD)}@gitlab.com/surfstudio/public/flutter-standard.git"
            }
        },
        pipeline.stage("Sanitize", StageStrategy.FAIL_WHEN_STAGE_ERROR) {
            dir("flutter-standard.git") {
                def packedRefsFile = "packed-refs"
                def packedRefs = readFile file: packedRefsFile
                echo "packed_refs: $packedRefs"
                def sanitizedPackedRefs = ""
                def checkNextToHash = false

                def taskPattern = ~/[A-Z]{3}-\d+-.+$/

                for (ref in packedRefs.split("\n")) {
                    if (checkNextToHash) {
                        checkNextToHash = false

                        if (ref.startsWith("^")) {
                            continue
                        }
                    }

                    if (!(ref.contains("project") || ref =~ taskPattern)) {
                        sanitizedPackedRefs += ref
                        sanitizedPackedRefs += "\n"
                    } else {
                        // we should remove hash of commit which can follow next with ^ marker, when tag removed
                        checkNextToHash = ref.contains("/tags/")
                    }
                }
                echo "sanitizedPackedRefs: $sanitizedPackedRefs"
                writeFile file: packedRefsFile, text: sanitizedPackedRefs
            }
        },
        pipeline.stage("Mirroring", StageStrategy.FAIL_WHEN_STAGE_ERROR) {
            dir("flutter-standard.git") {
                withCredentials([usernamePassword(credentialsId: mirrorRepoCredentialID, usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    echo "credentialsId: $mirrorRepoCredentialID"
                    sh "git push --mirror https://${encodeUrl(USERNAME)}:${encodeUrl(PASSWORD)}@github.com/surfstudio/SurfGear.git"
                }
            }
        }
]

pipeline.finalizeBody = {
    if (pipeline.jobResult == Result.FAILURE) {
        def message = "Ошибка зеркалирования AndroidStandard на GitHub. ${CommonUtil.getBuildUrlSlackLink(this)}"
        JarvisUtil.sendMessageToGroup(this, message, pipeline.repoUrl, "gitlab", false)
    }
}

//run
pipeline.run()