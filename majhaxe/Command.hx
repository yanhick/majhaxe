package;

enum Command 
{
    bash(cmd:Bash);
    func(fun:Void->Void);
}

/**
 * Represents a bash command
 */
typedef Bash =
{
    //an executable name
    var bin:String;

    //the arguments to call the executable with
    var args:Array<String>;

    //an error message to print if the executable returns an error
    var err:String;

    //an info message to print while running the command
    var info:String;
}
