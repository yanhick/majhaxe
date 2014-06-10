package;

import Command;

/**
 * Communicate with git 
 */ 
class Git
{
    public static function push(remote):Array<Command>
    {
        return [
            getGitCommand(
                    ['push', remote, Constants.DEFAULT_BRANCH],
                    'could not push to remote: ' + remote + ' ,on branch: ' + Constants.DEFAULT_BRANCH,
                    'pushing changes to remote: ' + remote + ' ,on branch: ' + Constants.DEFAULT_BRANCH),
            getGitCommand(
                    ['push', remote, Constants.GIT_TAGS],
                    'could not push tags to remote: ' + remote + ' ,on branch: ' + Constants.DEFAULT_BRANCH,
                    'pushing tags to remote: ' + remote + ' ,on branch: ' + Constants.DEFAULT_BRANCH)
        ].map(function (item) return bash(item));
    }

    public static function commit(version, comment):Array<Command>
    {
        if (comment == null)
            comment = 'update to version: ' + version;

        return [
            getGitCommand(
                    ['add', Constants.HAXELIB_JSON], 
                    'could not stage haxelib.json',
                    'staging haxelib.json'),
            getGitCommand(
                    ['commit', '-m', comment],
                    'could not commit',
                    'commit with message: ' + comment),
            getGitCommand(
                    ['tag', version],
                    'could not create a new tag', 
                    'creating tag: ' + version)
        ].map(function (item) return bash(item));
    }

    static function getGitCommand(args, err, info):Bash
    {
        return {
            bin: 'git',
            args: args,
            err: err,
            info: info
        }
    }
}   