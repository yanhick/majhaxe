package;

class UserInput
{
    public static function init(output:String->Void, input:Void->String)
    {
        output('project name ?');
        var project = input();

        output('licence ?');
        var licence = input();

        output('licence holder ?');
        var holder = input();

        output('targets ?');
        var targets = input();

        return {
            project: project,
            licence: licence,
            holder: holder,
            targets: targets
        }
    }
}
