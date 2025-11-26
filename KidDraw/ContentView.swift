//
//  ContentView.swift
//  KidDraw
//
//  Created by Luís Teixeira on 25.11.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model: DrawingViewModel
    
    var body: some View {
        DrawingCanvas(model: model)
            .toolbar {
                
                ToolbarItemGroup {
                    ForEach(ColorPallete.colors, id: \.self) { color in
                        ColorCircleButton(color: color, isSelected: model.currentColor == color) {
                            model.currentColor = color
                        }
                    }
                }
                
                ToolbarItemGroup{
                    ForEach(BrushType.allCases, id: \.self) { brush in
                        BrushTypeButton(
                            brush: brush,
                            isSelected: model.currentBrush == brush
                        ) {
                            model.currentBrush = brush
                        }
                    }
                }
                
                ToolbarItemGroup {
                    ForEach(BrushSize.allCases, id: \.self) { size in
                        BrushSizeButton(
                            size: size,
                            isSelected: model.currentSize == size
                        ) {
                            model.currentSize = size
                        }
                    }
                }
                
                ToolbarItem {
                    Button("Clear") {
                        model.strokes.removeAll()
                    }
                }
            }
            .navigationTitle("KidDraw")
    }
}
