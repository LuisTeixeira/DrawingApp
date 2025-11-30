import SwiftUI
import UniformTypeIdentifiers
import Combine

extension UTType {
    static let kiddraw = UTType(exportedAs: "com.lmteixeira.kiddraw")
}

class DrawingDocument: ReferenceFileDocument, ObservableObject {
    
    @Published var pages: [Page] = []

    static var readableContentTypes: [UTType] { [.kiddraw] }
    
    required init() {
        pages = []
    }
    
    required init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            pages = try JSONDecoder().decode([Page].self, from: data)
        } else {
            pages = []
        }
    }
    
    func snapshot(contentType: UTType) throws -> DrawingDocument {
        let copy = DrawingDocument()
        copy.pages = self.pages
        return copy
    }
    
    func fileWrapper(snapshot: DrawingDocument,
                     configuration: WriteConfiguration) throws -> FileWrapper {
        do {
            let data = try JSONEncoder().encode(snapshot.pages)
            return FileWrapper(regularFileWithContents: data)
        } catch {
            print("ENCODING ERROR: ", error)
            throw error
        }
    }
}
