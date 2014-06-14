package;

import Command;
import haxe.Template;
using Lambda;
import UserInput;

typedef Resources = {
    var createMIT:Int->String->String;
    var createMain:String->String;
    var createReadme:String->String->String;
    var createTravis:Array<String>->String->String;
    var createHXML:Array<String>->Array<String>->String->String;
    var createHaxelib:InitInput->String;
}

/**
 * Create resource files from templates
 */ 
class ResourcesImpl
{
    public static function get():Resources
    {
        var render = function(res) return new haxe.Template(haxe.Resource.getString(res));

        return {
            createMIT: function (year, holder) return render('mit').execute({year: year, holder:holder}),
            createMain: function (pack) return render('main').execute({pack: pack}),
            createReadme: function (name, description) return render('readme').execute({name: name, description: description}),
            createTravis: function (libs, build) return render('travis').execute({libs: libs, build: build}),
            createHXML: function (targets, libs, path) return render('hxml').execute({targets: filterTargets(targets), libs: libs, path: path}),
            createHaxelib: function (input) return render('haxelib').execute(input)
        };
    }

    static function filterTargets(requestedTargets:Array<String>)
    {
        return [{
            name: 'cpp',
            options: [],
            output: '-cpp bin'
        }, {
            name: 'js',
            options: [],
            output: '-js bin/main.js'
        }, {
            name: 'neko',
            options: [],
            output: '-neko bin/neko.n'
        }].filter(function (target) return requestedTargets.has(target.name));
    }
}
