//
//  ContentView.swift
//  KidDraw
//
//  Created by Luís Teixeira on 25.11.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model: MultiPageDocument
    @StateObject var commandManager = CommandManager()
    @StateObject var strokeStyleState = StrokeStyleState()
    
    var body: some View {
        MultiPageCavasView(document: model, commandManager: commandManager, strokeStyleState: strokeStyleState)
            .toolbar {
                ToolbarItemGroup {
                    Button {
                        commandManager.undo()
                    } label: {
                        Image(systemName: "arrow.uturn.backward")
                    }
                    .keyboardShortcut("z", modifiers: .command)
                    
                    Button {
                        commandManager.redo()
                    } label: {
                        Image(systemName: "arrow.uturn.forward")
                    }
                    .keyboardShortcut("z", modifiers: [.command, .shift])
                }
                
                ToolbarItemGroup {
                    ForEach(ColorPallete.colors, id: \.self) { color in
                        ColorCircleButton(color: color, isSelected: strokeStyleState.currentColor == color) {
                            strokeStyleState.currentColor = color
                        }
                    }
                }
                
                ToolbarItemGroup{
                    ForEach(BrushType.allCases, id: \.self) { brush in
                        BrushTypeButton(
                            brush: brush,
                            isSelected: strokeStyleState.currentBrush == brush
                        ) {
                            strokeStyleState.currentBrush = brush
                        }
                    }
                }
                
                ToolbarItemGroup {
                    ForEach(BrushSize.allCases, id: \.self) { size in
                        BrushSizeButton(
                            size: size,
                            isSelected: strokeStyleState.currentSize == size
                        ) {
                            strokeStyleState.currentSize = size
                        }
                    }
                }
                
                ToolbarItem {
                    Button("Clear") {
                        let clearAllCmd = ClearAllCommand(page: model.selectedPage)
                        commandManager.perform(clearAllCmd)
                    }
                }
            }
            .navigationTitle("KidDraw")
    }
}
