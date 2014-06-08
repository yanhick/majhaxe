package;

import semver.SemVer;

/**
 * Communication and configuration for haxelib submission
 */ 
class Haxelib
{

    //UPDATE HAXELIB.JSON

    /**
     * update the semver of the haxelib.json file
     */
    public static function update(config:Config, haxelib:Dynamic):Dynamic
    {
        haxelib.version = updateVersion(config.semver, haxelib.version);

        //update release note as well if a comment is provided
        if (config.comment != null)
            haxelib.releasenote = config.comment;

        return haxelib;
    }

    /**
     * Increment semver
     */ 
    static function updateVersion(semverUpdate:String, version:String):String
    {
        if (isSemverConstant(semverUpdate))
            return SemVer.inc(version, getSemverRelease(semverUpdate));

        //here a whole new semver version was provided
        return semverUpdate;
    }

    static function isSemverConstant(semverUpdate:String):Bool
    {
        return semverUpdate == 'minor' || semverUpdate == 'major' || semverUpdate == 'patch' || semverUpdate == 'build';
    }

    static function getSemverRelease(semver:String):Release
    {
        return switch(semver)
        {
            case 'minor': Minor;
            case 'major': Major;
            case 'patch': Patch;
            case 'build': Build;
            default: 
              Utils.error('not a semver release');
              null;
        }
    }

    //SUBMIT TO HAXELIB

    public static function submit(config:Config):Array<Command>
    {
        return [
            zip(config.exclude),
            {
                bin: 'haxelib',
                args: ['submit', Constants.HAXELIB_ZIP]
            },
            rmZip()
        ];
    }

    //INSTALL LOCALLY

    public static function local(config:Config):Array<Command>
    {
        return [
            zip(config.exclude),
            {
                bin: 'haxelib',
                args: ['local', Constants.HAXELIB_ZIP]
            },
            rmZip()
        ];
    }

    /**
     * create zip with all files in folder expect explicitely
     * excluded ones
     */
    static function zip(exclude:String):Command
    {
        var cmd = {
            bin: 'zip',
            args: ['-r', 'haxelib', '*']
        }

        if (exclude != null)
            cmd.args.concat(['-x', exclude]);

        return cmd;
    }

    /**
     * delete zip
     */
    static function rmZip():Command
    {
        return {
            bin: 'rm',
            args: [Constants.HAXELIB_ZIP]
        }
    }
}
