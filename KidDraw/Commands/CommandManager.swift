import Foundation

class CommandManager {
    
    private var undoStack: [DrawingCommand] = []
    private var redoStack: [DrawingCommand] = []
    
    func perform(_ command: DrawingCommand) {
        command.execute()
        undoStack.append(command)
        redoStack.removeAll()
    }
    
    func undo() {
        guard let cmd = undoStack.popLast() else {return}
        cmd.undo()
        redoStack.append(cmd)
    }
    
    func redo() {
        guard let cmd = redoStack.popLast() else {return}
        cmd.execute()
        undoStack.append(cmd)
    }
    
    func reset() {
        undoStack.removeAll()
        redoStack.removeAll()
    }
}
