package commands;

import Command;

/**
 * Display help
 */
class Help
{
    public static function get(config:Config):Array<Command>
    {
        return [{
            cmd: func(Sys.println.bind(haxe.Resource.getString('usage'))),
            err: 'could not display help',
            info: ''
        }];
    }
}

