package;

import Command;
import haxe.Template;

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
}
