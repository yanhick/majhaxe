package;

import buddy.*;
using buddy.Should;

import Resources;
import haxe.Json;
import UserInput;

class TestResources extends BuddySuite implements Buddy {
    public function new() {
        describe('resource', function () {

            var resources = ResourcesImpl.get();

            describe('#license', function () {
                it('should generate an MIT license', function () {
                    var license = resources.createMIT(
                        Date.now().getFullYear(),
                        'test holder');
                    license.indexOf(Std.string(Date.now().getFullYear())).should.not.be(-1);
                    license.indexOf('test holder').should.not.be(-1);
                });
            });
            
            describe('#travis', function () {
                it('should generate a travis file', function () {
                    var travis = resources.createTravis(['my-lib'], 'test.hxml');
                    travis.indexOf('test.hxml').should.not.be(-1);
                    travis.indexOf('my-lib').should.not.be(-1);
                });
            });

            describe('#main', function () {
                it('should generate a main Haxe file', function () {
                    var main = resources.createMain('test');
                    main.indexOf('main').should.not.be(-1);
                    main.indexOf('package').should.not.be(-1);
                    main.indexOf('test').should.not.be(-1);
                });
            });

            describe('#hxml', function () {
                it('should generate an .hxml file', function () {
                    var hxml = resources.createHXML(['js', 'cpp'], ['my-lib'], 'test');
                    hxml.indexOf('js').should.not.be(-1);
                    hxml.indexOf('cpp').should.not.be(-1);
                    hxml.indexOf('my-lib').should.not.be(-1);
                    hxml.indexOf('test').should.not.be(-1);
                    hxml.indexOf('neko').should.be(-1);
                });
            });

            describe('#readme', function () {
                it('should generate a readme file', function () {
                    var readme = resources.createReadme('test', 'test description');
                    readme.indexOf('test').should.not.be(-1);
                    readme.indexOf('test description').should.not.be(-1);
                });
            });

            describe('#haxelib', function () {
                it('should generate a haxelib file', function () {
                    var input:InitInput = {
                        project: 'test-project',
                        description: 'my test project',
                        license: MIT,
                        source: 'source',
                        holder: 'test holder',
                        dependencies: ['mylib', 'myotherlib'],
                        targets: ['js']
                    };
                    var haxelib = resources.createHaxelib(input);
                    var haxelibJSON = Json.parse(haxelib);
                    var name:String = haxelibJSON.name;
                    var license:String = haxelibJSON.license;
                    var contributor:Array<String> = haxelibJSON.contributors;
                    var description:String = haxelibJSON.description;
                    var dependencies:Dynamic = haxelibJSON.dependencies;

                    name.should.be('test-project');
                    license.should.be('MIT');
                    contributor[0].should.be('test holder');
                    description.should.be('my test project');
                });
            });
        });
    }

}

