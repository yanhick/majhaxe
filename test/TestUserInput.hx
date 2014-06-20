package;

import buddy.*;
using buddy.Should;


import Command;


class TestUserInput extends BuddySuite implements Buddy {

    public function new()
    {
        describe('UserInput', function () {
            describe('#init', function () {
                it('should store user input for project init', function () {

                    var getInput = function () {
                        var inputs = ['test', '0.0.0', 'description', 'http://project-url', 'source', 'MIT', 'holder', 'js php', 'lib1 lib2'];
                        return function () return inputs.shift();
                    };
                    var output = function (str) {};

                    var input = UserInput.init(output, getInput());
                    input.project.should.be('test');
                    input.version.should.be('0.0.0');
                    input.url.should.be('http://project-url');
                    input.description.should.be('description');
                    input.source.should.be('source');
                    input.license.should.be(MIT);
                    input.holder.should.be('holder');
                    input.dependencies[0].should.be('lib1');
                    input.dependencies[1].should.be('lib2');
                    input.targets[0].should.be('js');
                    input.targets[1].should.be('php');
                });
            });
        });
    }
}
