package;

/**
 * CLI utils 
 */ 
class Utils
{
    public static function error(err)
    {
        Sys.println(err);
        Sys.exit(1);
    }

    public static function command(cmd, args)
    {
        var ret = Sys.command(cmd, args);
        if (ret != 0)
            error('could not execute: ' + cmd);
    }
}

