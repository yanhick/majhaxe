package;

import buddy.*;
using buddy.Should;

import Command;
import commands.Local;
import Config;
using Lambda;


class TestLocal extends BuddySuite implements Buddy {

    public function new()
    {
        var createConfig = function () {
            return {
                semver: '0.1.0',
                noCommit: false,
                noPush: false,
                noGit: false,
                comment: 'comment',
                remote: null,
                exclude: null,
                dryRun: false
            }
        }

        describe('Local', function () {
            it('should install haxelib locally', function () {
                Local.get(createConfig())
                .foreach(function (command) {
                    return switch(command.cmd) {
                        case bash('zip' | 'haxelib' | 'rm', _): true;
                        case _: false;
                    }
                }).should.be(true);
            });
        });
    }
}
