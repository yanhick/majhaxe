package;

import buddy.*;
using buddy.Should;

class TestInstall extends BuddySuite implements Buddy {
    public function new() {
        describe('install', function () {

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

