@Model
struct VocabularyEntry: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    var korean: String
    var english: String

    init(korean: String, english: String) {
        self.id = UUID()
        self.korean = korean
        self.english = english
    }
}