package;

import Command;

/**
 * Create File Sytem commands
 */ 
class FS
{
    public static function mkdir(name)
    {
        return {
            cmd: bash('mkdir', [name]),
            err: 'could not create dir:' + name,
            info: 'creating dir: ' + name
        }
    }
}
