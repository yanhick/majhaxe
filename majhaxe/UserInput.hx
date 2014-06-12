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

        output('dependencies ?');
        var dependencies = input();

        return {
            project: project,
            licence: licence,
            holder: holder,
            dependencies: dependencies.split(' '),
            targets: targets
        }
    }
}
