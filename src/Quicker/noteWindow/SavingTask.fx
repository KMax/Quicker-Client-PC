/*
 * SavingTask.fx
 *
 * Created on 24.04.2010, 18:40:29
 */

package Quicker.noteWindow;

import javafx.async.JavaTaskBase;
import javafx.async.RunnableFuture;
import Quicker.Note;

/**
 * @author Maxim
 */

public class SavingTask extends JavaTaskBase {
    public var n: Note;
    override protected function create () : RunnableFuture {
        new GoSave(n);
    }


}
