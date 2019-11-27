@Library('surf-lib@flutter_firebase_app_distribution') // https://bitbucket.org/surfstudio/jenkins-pipeline-lib/ //todo change version to snapshot
import ru.surfstudio.ci.pipeline.pr.PrPipelineFlutter
import ru.surfstudio.ci.stage.StageStrategy

//init
def pipeline = new PrPipelineFlutter(this)
pipeline.init()

pipeline.androidKeystoreCredentials = null //todo
pipeline.androidKeystorePropertiesCredentials = null //todo

//customization
// хардкод исполнения сборки на определённой ноде
// pipeline.node="android-1"
pipeline.getStage(pipeline.UNIT_TEST).strategy = StageStrategy.SKIP_STAGE
// pipeline.getStage(pipeline.CHECKOUT_FLUTTER_VERSION).strategy = StageStrategy.SKIP_STAGE
pipeline.getStage(pipeline.STAGE_IOS).node="ios-4"
pipeline.getStage(pipeline.STATIC_CODE_ANALYSIS).strategy = StageStrategy.SKIP_STAGE

//run
pipeline.run()
