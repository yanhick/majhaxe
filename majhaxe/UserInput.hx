package;

enum License {
    MIT;
}

typedef InitInput = {
    var project:String;
    var description:String;
    var license:License;
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

        output('description ?');
        var description = input();

        output('license ?');
        var license = getLicense(input());

        output('license holder ?');
        var holder = input();

        output('targets ?');
        var targets = input();

        output('dependencies ?');
        var dependencies = input();

        return {
            project: project,
            description: description,
            license: license,
            holder: holder,
            dependencies: dependencies.split(' '),
            targets: targets.split(' ')
        }
    }

    static function getLicense(input)
    {
        return switch(input) 
        {
            case 'MIT': MIT;
            case _: MIT;
        }
    }
}

