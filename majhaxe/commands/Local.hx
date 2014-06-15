package commands;

import haxe.Json;

/**
 * Install the lib locally
 */
class Local
{
    public static function get(config:Config):Array<Command>
    {
        return Haxelib.local(config);
    }
}

