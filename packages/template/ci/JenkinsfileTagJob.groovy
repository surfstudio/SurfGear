@Library('surf-lib@flutter') // https://bitbucket.org/surfstudio/jenkins-pipeline-lib/ //todo change version to snapshot
import ru.surfstudio.ci.pipeline.tag.TagPipelineFlutter
import ru.surfstudio.ci.stage.StageStrategy

//init
def pipeline = new TagPipelineFlutter(this)

pipeline.init()

//configuration
//TODO: set real values ↓↓↓ (mechanism see in AndroidUtil.withKeystore)
pipeline.androidKeystoreCredentials = null
pipeline.androidKeystorePropertiesCredentials = null


//customization
pipeline.getStage(pipeline.CLEAN_PREV_BUILD).strategy = StageStrategy.SKIP_STAGE
pipeline.getStage(pipeline.UNIT_TEST).strategy = StageStrategy.SKIP_STAGE
pipeline.getStage(pipeline.STATIC_CODE_ANALYSIS).strategy = StageStrategy.SKIP_STAGE



// project specific


//run
pipeline.run()