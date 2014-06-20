package;

import buddy.*;
using buddy.Should;


import Command;


class TestUserInput extends BuddySuite implements Buddy {

    public function new()
    {
        describe('UserInput', function () {

            var getInput = function () {
                return ['test', '0.0.0', 'description', 'http://project-url', 'source', 'MIT', 'holder', 'me you', 'js php', 'lib1 lib2'];
            };
            var stdin = function (inputs) {
                return function () return inputs.shift();
            };

            var output = function (str) {};
            var initUserInput = UserInput.init.bind(output);
            
            describe('#init', function () {
                it('should store user input for project init', function () {

                    var input = initUserInput(stdin(getInput()));
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
                    input.contributors[0].should.be('me');
                    input.contributors[1].should.be('you');
                });

                it('should default source dir to project name', function () {
                    var input = getInput();
                    input[4] = '';
                    var userInput = initUserInput(stdin(input));
                    userInput.source.should.be('test');
                });

                it('should default version to 0.0.0', function () {
                    var input = getInput();
                    input[1] = '';
                    var userInput = initUserInput(stdin(input));
                    userInput.version.should.be('0.0.0');
                });

                it('should default invalid semver to 0.0.0', function () {
                    var input = getInput();
                    input[1] = 'notsemver';
                    var userInput = initUserInput(stdin(input));
                    userInput.version.should.be('0.0.0');
                });

                it('should default licence to mit', function () {
                    var input = getInput();
                    input[5] = '';
                    var userInput = initUserInput(stdin(input));
                    userInput.license.should.be(MIT);
                });

                it('should filter invalid targets', function () {
                    var input = getInput();
                    input[8] = 'js perl';
                    var userInput = initUserInput(stdin(input));
                    userInput.targets.length.should.be(1);
                    userInput.targets[0].should.be('js');
                });
            });
        });
    }
}
