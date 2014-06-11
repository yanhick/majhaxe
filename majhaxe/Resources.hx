package;

import Command;
import haxe.Template;

/**
 * Create Licence files
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
}
