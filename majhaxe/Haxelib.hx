package;

import semver.SemVer;
import Command;

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
              throw 'not a semver release';
              null;
        }
    }

    //SUBMIT TO HAXELIB

    public static function submit(config:Config):Array<Command>
    {
        return [
            zip(config.exclude),
            {
                cmd: bash('haxelib', ['submit', Constants.HAXELIB_ZIP]),
                err: 'could not submit haxelib.zip to haxelib',
                info:'submitting haxelib.zip to haxelib'
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
                cmd: bash('haxelib', ['local', Constants.HAXELIB_ZIP]),
                err: 'could not install haxelib.zip locally',
                info:'installing haxelib.zip locally'
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
        var args = ['-r', 'haxelib', '*'];

        if (exclude != null)
            args.concat(['-x', exclude]);

        return {
            cmd: bash('zip', args),
            err: 'could not create haxelib.zip',
            info:'creating haxelib.zip, excluding: ' + exclude
        }
    }

    /**
     * delete zip
     */
    static function rmZip():Command
    {
        return {
            cmd: bash('rm', [Constants.HAXELIB_ZIP]),
            err: 'could not delete haxelib.zip',
            info:'deleting haxelib.zip'
        }
    }

    //INSTALL AN HAXELIB

    public static function install(libs:Array<String>):Array<Command>
    {
        return libs.map(function (lib) {
            return {
                cmd: bash('haxelib', ['install', lib]), 
                err: 'could not install: ' + lib,
                info: 'installing: ' + lib
            }
        });
    }
}
