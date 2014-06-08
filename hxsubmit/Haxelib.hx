package;

import haxe.Json;
import semver.SemVer;

/**
 * Communication and configuration for haxelib submission
 */ 
class Haxelib
{

    //UPDATE HAXELIB.JSON

    /**
     * update the semver of the haxelib.josn file
     */
    public static function update(config:Config):String
    {
        var haxelib:Dynamic = Json.parse(sys.io.File.getContent(Constants.HAXELIB_JSON));
        haxelib.version = updateVersion(config.semver, haxelib.version);

        //update release note as well if a comment is provided
        if (config.comment != null)
            haxelib.releasenote = config.comment;

        sys.io.File.saveContent(Constants.HAXELIB_JSON, Json.stringify(haxelib));

        return haxelib.version;
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

    static function isSemverConstant(semverUpdate:String)
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

    public static function submit(config:Config)
    {
        zip(config.exclude);

        Utils.command('haxelib', ['submit', Constants.HAXELIB_ZIP]);

        rmZip();
    }

    //INSTALL LOCALLY

    public static function local(config:Config)
    {
        zip(config.exclude);

        Utils.command('haxelib', ['local', Constants.HAXELIB_ZIP]);

        rmZip();
    }

    /**
     * create zip with all files in folder expect explicitely
     * excluded ones
     */
    static function zip(exclude:String)
    {
        if (exclude != null)
            Utils.command('zip', ['-r', 'haxelib', '*', '-x', exclude]);
        else
            Utils.command('zip', ['-r', 'haxelib', '*']);
    }

    /**
     * delete zip
     */
    static function rmZip()
    {
        Utils.command('rm', [Constants.HAXELIB_ZIP]);
    }
}
