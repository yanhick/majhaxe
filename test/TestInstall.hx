package;

import commands.Install;
import Config;
import haxe.Json;

import buddy.*;
using buddy.Should;
using Lambda;

class TestInstall extends BuddySuite implements Buddy {
    public function new() {
        describe('#install', function () {

            var io = {
                input: function () return '',
                output: function (str) {},
                read: function (content) {
                    return Json.stringify({
                        dependencies: ['mylib', 'myotherlib']
                    });
                },
                write: function (path, content){},
                exists: function (path) return true
            };

            it('should install all the dependencies in the haxelib.json file', function () {

                var commands = Install.install(ConfigImpl.get([]), io);
                commands.length.should.be(2);
                commands.foreach(function (command) {
                    return switch(command.cmd) {
                        case bash('haxelib', ['install', 'mylib' | 'myotherlib']): true;
                        case _: false;
                    }
                }).should.be(true);
            });

            it('should throw if there is nothing to install');

            describe('#dependencies', function () {
                it('should store the installed dependencies in the haxelib.json file');
            });

            describe('#hxml', function() {
                it('should update the .hxml file with the new lib');
            });

            describe('#travis', function () {
                it('should update travis with the new lib');
            });
        });

        describe('remove', function () {
            describe('#haxelib', function () {
                it('should remove the installed dependencies from the haxelib.json file');
            });

            describe('#hxml', function () {
                it('should remove the lib from the hxml');
            });

            describe('#travis', function () {
                it('should remove the lib from travis installation');
            });
        });
    }

}

