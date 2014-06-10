package;

/**
 * executable code, either as bash or func
 */ 
enum Exec
{
    bash(bin:String, args:Array<String>);
    func(fun:Void->Void);
}

/**
 * a generic command, executed via bash or a haxe function
 */
typedef Command =
{
    var cmd:Exec;

    //an error message to print if the executable returns an error
    var err:String;

    //an info message to print while running the command
    var info:String;
}
