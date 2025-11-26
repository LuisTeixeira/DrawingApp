import SwiftUI
import UniformTypeIdentifiers
import Combine

extension UTType {
    static let kiddraw = UTType(exportedAs: "com.lmteixeira.kiddraw")
}

class DrawingDocument: ReferenceFileDocument, ObservableObject {
    
    @Published var strokes: [Stroke] = []

    static var readableContentTypes: [UTType] { [.kiddraw] }
    
    required init() {
        strokes = []
    }
    
    required init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            strokes = try JSONDecoder().decode([Stroke].self, from: data)
        } else {
            strokes = []
        }
    }
    
    func snapshot(contentType: UTType) throws -> DrawingDocument {
        let copy = DrawingDocument()
        copy.strokes = self.strokes
        return copy
    }
    
    func fileWrapper(snapshot: DrawingDocument,
                     configuration: WriteConfiguration) throws -> FileWrapper {
        do {
            let data = try JSONEncoder().encode(snapshot.strokes)
            return FileWrapper(regularFileWithContents: data)
        } catch {
            print("ENCODING ERROR: ", error)
            throw error
        }
    }
}
