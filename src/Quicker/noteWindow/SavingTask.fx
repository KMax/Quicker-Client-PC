package Quicker.noteWindow;

import javafx.async.JavaTaskBase;
import javafx.async.RunnableFuture;
import Quicker.Note;

public class SavingTask extends JavaTaskBase {
    public var n: Note;
    public var listener: SaveListener;
    override protected function create () : RunnableFuture {
        new GoSave(n, listener);
    }
}
