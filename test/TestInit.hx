package;

import buddy.*;
using buddy.Should;

import Command;
import commands.Init;
import UserInput;

using Lambda;

class TestInit extends BuddySuite implements Buddy {

    public function new()
    {
        describe('Init', function () {
            it('should create a git repo', function () {
                var io = {
                    input: function () return '',
                    output: function (str) {},
                    read: function (content) return '',
                    write: function (path, content){},
                    exists: function (path) return true
                };

                var resources:Resources = {
                    createMIT: function(date, holder) {
                        date.should.be(Date.now().getFullYear());
                        holder.should.be('test holder');
                        return 'MIT';
                    },
                    createTravis: function (deps, build) {
                        deps[0].should.be('mylib');
                        build.should.be('haxe build.hxml');
                        return 'travis';
                    },
                    createMain: function (pack) {
                        pack.should.be('test-project');
                        return 'main';
                    },
                    createReadme: function (name, description) {
                        name.should.be('test-project');
                        description.should.be('my test project');
                        return 'readme';
                    },
                    createHXML: function (targets, libs, path) {
                        targets[0].should.be('js');
                        libs[0].should.be('mylib');
                        path.should.be('test-project');
                        return 'hxml';
                    }
                };

                var input:InitInput = {
                    project: 'test-project',
                    description: 'my test project',
                    licence: MIT,
                    holder: 'test holder',
                    dependencies: ['mylib'],
                    targets: ['js']
                };

                var commands = Init.get(Config.get([]), io, resources, input);
                commands.foreach(function (command) {
                    return switch(command.cmd) {
                        case func(fn):
                            fn();
                            true;
                        case bash(_, _): true;
                        case _: false;
                    }
                }).should.be(true);
            });
        });
    }
}
