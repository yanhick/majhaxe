package commands;

import Command;

/**
 * Init a new Haxe project
 */
class Init
{
    public static function get(config:Config, io:IO):Array<Command>
    {
        var input = UserInput.init(io.output, io.input);

        var commands = [Git.init()];
        return commands;
    }
}

