package;

enum Licence {
    MIT;
}

typedef InitInput = {
    var project:String;
    var licence:Licence;
    var holder:String;
    var dependencies:Array<String>;
    var targets:Array<String>;
}

class UserInput
{
    public static function init(output:String->Void, input:Void->String):InitInput
    {
        output('project name ?');
        var project = input();

        output('licence ?');
        var licence = getLicence(input());

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
            targets: targets.split(' ')
        }
    }

    static function getLicence(input)
    {
        return switch(input) 
        {
            case 'MIT': MIT;
            case _: MIT;
        }
    }
}

