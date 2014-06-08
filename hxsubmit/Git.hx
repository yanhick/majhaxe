package;

/**
 * Communicate with git 
 */ 
class Git
{
    public static function push(remote)
    {
        Utils.command('git', ['push', remote, Constants.DEFAULT_BRANCH]);
        Utils.command('git', ['push', remote, Constants.GIT_TAGS]);
    }

    public static function commit(version, comment)
    {
        if (comment == null)
            comment = 'update to version: ' + version;

        Utils.command('git', ['add', Constants.HAXELIB_JSON]);

        Utils.command('git', ['commit', '-m', comment]);

        Utils.command('git', ['tag', version]);
    }
}   
