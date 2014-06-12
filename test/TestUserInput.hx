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
                        var inputs = ['test', 'mit', 'js php'];
                        return function () return inputs.shift();
                    };
                    var output = function (str) {};

                    var input = UserInput.init(output, getInput());
                    input.project.should.be('test');
                    input.licence.should.be('mit');
                    input.targets.should.be('js php');
                });
            });
        });
    }
}
