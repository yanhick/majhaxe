package;

import buddy.*;
using buddy.Should;

class TestResources extends BuddySuite implements Buddy {
    public function new() {
        describe('resource', function () {

            describe('#licence', function () {
                it('should generate an MIT licence', function () {
                    var licence = Resources.createMIT(
                        Date.now().getFullYear(),
                        'test holder');
                    licence.indexOf(Std.string(Date.now().getFullYear())).should.not.be(-1);
                    licence.indexOf('test holder').should.not.be(-1);
                });
            });
            
            describe('#travis', function () {
                it('should generate a travis file');
            });

            describe('#main', function () {
                it('should generate a main Haxe file');
            });

            describe('#hxml', function () {
                it('should generate an .hxml file');
            });

            describe('#readme', function () {
                it('should generate a readme file');
            });
        });
    }

}

