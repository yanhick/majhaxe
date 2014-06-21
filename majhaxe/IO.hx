package;

/**
 * IO abstraction
 */
typedef IO = {

    //output to stdout
    var output: String->Void;

    //read from stdin
    var input: Void->String;

    //read file
    var read: String->String;

    //write file
    var write: String->String->Void;

    //check if file exists
    var exists: String->Bool;
}

class IOImpl
{
    public static function get(dryRun:Bool) 
    {
        return {
            output: Sys.println,
            input: function () return Sys.stdin().readLine(),
            read: sys.io.File.getContent,
            write: function (path, content) {
                if (!dryRun) sys.io.File.saveContent(path, content);
            },
            exists: sys.FileSystem.exists
        };
    }
}
