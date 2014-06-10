package;

import buddy.*;
using buddy.Should;

class TestProject extends BuddySuite implements Buddy {
    public function new() {
        describe('project', function () {

            describe('#haxelib', function () {
                it('should generate a haxelib.json file');
            });
            
            describe('#git', function () {
                it('should init a git repo');
            });

            describe('#licence', function () {
                it('should generate a licence for the project');
            });

            describe('#dependencies', function () {
                it('should install the provided dependencies');
            });

            describe('#readme', function () {
                it('should create a readme');
            });
            
            describe('#travis', function () {
                it('should add a travis file');
            });

            describe('#source', function () {
                it('should create a source folder');
                it('should create a Main file');
            });

            describe('#hxml', function () {
                it('should create an hxml file');
            });
        });
    }
}

