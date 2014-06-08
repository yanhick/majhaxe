package;

import arguable.ArgParser;
import semver.SemVer;

/**
 * Create conf from command line arguments 
 */ 
class Config
{
    public static function get(SysArgs:Array<String>):Config
    {
        //first argument should be the semver update to perform
        var first = SysArgs.shift();

        var semver = switch(first) 
        {
            case 'minor', 'major', 'patch', 'build': first;
            default: first;
                if (!SemVer.valid(first))
                    Utils.error('semver is not valid');

                first;
        }

        var args = ArgParser.parse(Sys.args());

        var comment = null;
        if (args.has('m'))
            comment = args.get('m').value;

        var remote = Constants.DEFAULT_REMOTE;
        if (args.has('remote'))
            remote = args.get('remote').value;

        var exclude = null;
        if (args.has('exclude'))
            exclude = args.get('exclude').value;

        return new Config(comment, semver, args.has('no-commit'), 
                args.has('no-push'), remote, exclude, args.has('local'));
    }

    //an optional comment used for the commit and release note
    public var comment(default, null):String;

    //which semver part to update or a new semver version
    public var semver(default, null): String;

    //flag to prevent git commit
    public var noCommit(default, null): Bool;

    //flag to prevent git push 
    public var noPush(default, null): Bool;

    //git remote to push to
    public var remote(default, null): String;

    //list of files to exclude from zip sent to haxelib
    public var exclude(default, null): String;

    //flag to install haxelib locally instead of submitting it
    public var local(default, null): Bool;

    private function new(comment:String, semver:String, 
            noCommit:Bool, noPush:Bool,
            remote:String, exclude:String, local:Bool) 
    {
        this.comment = comment;
        this.semver = semver;
        this.noCommit= noCommit;
        this.noPush = noPush;
        this.remote = remote;
        this.exclude = exclude;
        this.local = local;
    }
}
