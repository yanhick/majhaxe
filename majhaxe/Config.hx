package;

import arguable.ArgParser;
import semver.SemVer;
using Lambda;

/**
 * Create conf from command line arguments 
 */ 
class Config
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

        return new Config(comment, semver, args.has('no-commit'), 
                args.has('no-push'), remote, exclude, args.has('local'), args.has('dry-run'));
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

    //flag to test the command that will be run without actually running them
    public var dryRun(default, null):Bool;

    private function new(comment:String, semver:String, 
            noCommit:Bool, noPush:Bool,
            remote:String, exclude:String, local:Bool, dryRun:Bool) 
    {
        this.comment = comment;
        this.semver = semver;
        this.noCommit= noCommit;
        this.noPush = noPush;
        this.remote = remote;
        this.exclude = exclude;
        this.local = local;
        this.dryRun = dryRun;
    }
}
