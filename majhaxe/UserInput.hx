package;

import semver.SemVer;
using Lambda;

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
        output('name: (dev)');
        var project = input();

        output('version: (0.0.0)');
        var version = input();

        if (version == '' || !SemVer.valid(version)) version = '0.0.0';

        output('description:');
        var description = input();

        output('url');
        var url = input();

        output('source dir: (default to name)');
        var source = input();

        if (source == '') source = project;

        output('license: ');
        var license = getLicense(input());

        output('license holder: ');
        var holder = input();

        output('targets: (space separated list among: js flash php java cs neko cpp)');
        var targets = input()
            .split(' ')
            .filter(function(target) {
                return ['js', 'php', 'flash', 'java', 'cs', 'neko', 'cpp'].has(target);
            });

        output('dependencies: (space separated list of haxelibs)');
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
            targets: targets
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

