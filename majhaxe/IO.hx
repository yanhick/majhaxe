package;

typedef IO = {
    var output: String->Void;
    var input: Void->String;
    var read: String->String;
    var write: String->String->Void;
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
