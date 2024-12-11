import Foundation
import SwiftData

@Model
final class User {
    @Attribute(.unique) var id: UUID
    var name: String
    
    // MARK: - Initializer
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
