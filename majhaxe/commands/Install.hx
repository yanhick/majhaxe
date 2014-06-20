package commands;

import Command;
import Resources;
import UserInput;

/**
 * Install haxelib dependencies
 */
class Install
{
    /**
     * Install all the haxelibs listed as dependencies
     */
    public static function install(config:Config, io:IO):Array<Command>
    {
        var haxelib = Haxelib.get(io);
        if(haxelib.dependencies == null) throw 'no dependencies to install';

        var dependencies:Array<String> = haxelib.dependencies;
        return Haxelib.install(dependencies);
    }
}

