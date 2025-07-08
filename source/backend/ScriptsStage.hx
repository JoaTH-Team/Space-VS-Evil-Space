package backend;

class ScriptsStage extends ScriptsGame
{
    public function new(nameStage:String) {
        super('stages/$nameStage');

        set('getStageImage', function (nameFile:String) {
            return Paths.images('stages/$nameStage/$nameFile');
        });
    }    
}