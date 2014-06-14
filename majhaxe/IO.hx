package;

typedef IO = {
    var output: String->Void;
    var input: Void->String;
    var read: String->String;
    var write: String->String->Void;
    var exists: String->Bool;
}
