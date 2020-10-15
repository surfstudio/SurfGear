@Library('surf-lib@flutter')
import ru.surfstudio.ci.pipeline.pr.PrPipelineFlutter
@Library('surf-lib@flutter')
// https://bitbucket.org/surfstudio/jenkins-pipeline-lib/ //todo change version to snapshot
import ru.surfstudio.ci.pipeline.pr.PrPipelineFlutter
import ru.surfstudio.ci.stage.StageStrategy

//init
def pipeline = new PrPipelineFlutter(this)
pipeline.init()

pipeline.androidKeystoreCredentials = null //todo
pipeline.androidKeystorePropertiesCredentials = null //todo

pipeline.getStage(pipeline.UNIT_TEST).strategy = StageStrategy.SKIP_STAGE
pipeline.getStage(pipeline.STATIC_CODE_ANALYSIS).strategy = StageStrategy.SKIP_STAGE

//run
pipeline.run()
