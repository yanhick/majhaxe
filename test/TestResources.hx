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
                it('should generate a travis file', function () {
                    var travis = Resources.createTravis(['my-lib'], 'test.hxml');
                    trace(travis);
                    travis.indexOf('test.hxml').should.not.be(-1);
                    travis.indexOf('my-lib').should.not.be(-1);
                });
            });

            describe('#main', function () {
                it('should generate a main Haxe file', function () {
                    var main = Resources.createMain('test');
                    main.indexOf('main').should.not.be(-1);
                    main.indexOf('package').should.not.be(-1);
                    main.indexOf('test').should.not.be(-1);
                });
            });

            describe('#hxml', function () {
                it('should generate an .hxml file', function () {
                    var hxml = Resources.createHXML(['js', 'cpp'], ['my-lib'], 'test');
                    trace(hxml);
                    hxml.indexOf('js').should.not.be(-1);
                    hxml.indexOf('cpp').should.not.be(-1);
                    hxml.indexOf('my-lib').should.not.be(-1);
                    hxml.indexOf('test').should.not.be(-1);
                    hxml.indexOf('neko').should.be(-1);
                });
            });

            describe('#readme', function () {
                it('should generate a readme file', function () {
                    var readme = Resources.createReadme('test', 'test description');
                    readme.indexOf('test').should.not.be(-1);
                    readme.indexOf('test description').should.not.be(-1);
                });
            });
        });
    }

}

