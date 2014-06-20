package;

enum License {
    MIT;
}

typedef InitInput = {
    var project:String;
    var version:String;
    var url:String;
    var description:String;
    var license:License;
    var holder:String;
    var source:String;
    var dependencies:Array<String>;
    var targets:Array<String>;
}

class UserInput
{
    public static function init(output:String->Void, input:Void->String):InitInput
    {
        output('project name ?');
        var project = input();

        output('version ?');
        var version = input();

        output('description ?');
        var description = input();

        output('url ?');
        var url = input();

        output('source dir ?');
        var source = input();

        if (source == '') source = project;

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
            version: version,
            url: url,
            description: description,
            license: license,
            source: source,
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

