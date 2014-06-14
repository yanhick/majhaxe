package commands;

import Command;

/**
 * Display help
 */
class Help
{
    public static function get(output:String->Void):Array<Command>
    {
        return [{
            cmd: func(output.bind(haxe.Resource.getString('usage'))),
            err: 'could not display help',
            info: ''
        }];
    }
}

