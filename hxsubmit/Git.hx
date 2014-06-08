package;

/**
 * Communicate with git 
 */ 
class Git
{
    public static function push(remote):Array<Command>
    {
        return [
            ['push', remote, Constants.DEFAULT_BRANCH],
            ['push', remote, Constants.GIT_TAGS]
        ].map(getGitCommand.bind());
    }

    public static function commit(version, comment):Array<Command>
    {
        if (comment == null)
            comment = 'update to version: ' + version;

        return [
            ['add', Constants.HAXELIB_JSON],
            ['commit', '-m', comment],
            ['tag', version]
         ].map(getGitCommand.bind());
    }

    static function getGitCommand(args):Command
    {
        return {
            bin: 'git',
            args: args
        }
    }
}   
