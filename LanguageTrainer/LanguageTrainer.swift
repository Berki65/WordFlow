import SwiftUI
import SwiftData

@main
struct LanguageTrainer: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(for: [User.self/*, VocabularyEntry.self*/])
        }
    }
}
