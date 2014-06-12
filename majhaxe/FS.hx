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

    public static function write(file, content):Command
    {
        return {
            cmd: func(function () {
                sys.io.File.saveContent(file, content);
            }),
            err: 'could not write to:' + file,
            info: 'writing to: ' + file
        }
    }
}
