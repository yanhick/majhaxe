package;

import arguable.ArgParser;
import semver.SemVer;
using Lambda;

typedef Config = {
    //a comment used for the commit and release note
    var comment:String;

    //which semver part to update or a new semver version
    var semver:String;

    //flag to prevent creating a git repo
    var noGit:Bool;

    //flag to prevent git commit
    var noCommit:Bool;

    //flag to prevent git push 
    var noPush:Bool;

    //git remote to push to
    var remote:String;

    //list of files to exclude from zip sent to haxelib
    var exclude:String;

    //flag to test the command that will be run without actually running them
    var dryRun:Bool;
}

/**
 * Create conf from command line arguments 
 */ 
class ConfigImpl
{
    public static function get(sysArgs:Array<String>):Config
    {
        var args = ArgParser.parse(sysArgs);

        var semver = getSemver(sysArgs);

        var comment = null;
        if (args.has('m'))
            comment = args.get('m').value;

        var remote = Constants.DEFAULT_REMOTE;
        if (args.has('remote'))
            remote = args.get('remote').value;

        var exclude = null;
        if (args.has('exclude'))
            exclude = args.get('exclude').value;

        return {
            comment: comment,
            semver: semver,
            noCommit: args.has('no-commit'),
            noPush: args.has('no-push'),
            noGit: args.has('no-git'),
            remote: remote,
            exclude: exclude,
            dryRun: args.has('dry-run')
        }
    }

    static function getSemver(args:Array<String>):String
    {
        return args.find(function (arg) {
            return switch(arg)
            {
                case 'minor', 'major', 'patch', 'build': true;
                default: SemVer.valid(arg);
            }
        });
    }
}
