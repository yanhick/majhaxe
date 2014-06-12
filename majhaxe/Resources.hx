package;

import Command;
import haxe.Template;
using Lambda;

/**
 * Create resource files from templates
 */ 
class Resources
{
    public static function createMIT(year:Int, holder:String):String
    {
        return new Template(haxe.Resource.getString('mit')).execute({
            year: year,
            holder: holder
        });
    }

    public static function createMain(pack:String):String
    {
        return new Template(haxe.Resource.getString('main')).execute({
            pack: pack
        });
    }

    public static function createReadme(name:String, description:String):String
    {
        return new Template(haxe.Resource.getString('readme')).execute({
            name: name,
            description: description
        });
    }

    public static function createTravis(libs:Array<String>, build:String):String
    {
        return new Template(haxe.Resource.getString('travis')).execute({
            libs: libs,
            build: build
        });
    }

    public static function createHXML(neededTargets:Array<String>, libs:Array<String>, path:String):String
    {
        var targets = [{
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
        }].filter(function (target) return neededTargets.has(target.name));

        return new Template(haxe.Resource.getString('hxml')).execute({
            targets: targets,
            libs: libs,
            path: path
        });
    }
}
