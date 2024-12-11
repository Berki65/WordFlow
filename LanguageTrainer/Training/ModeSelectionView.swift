import SwiftUI

enum PracticeMode: Hashable {
    case numbers
    case vocabulary
    case translation
}

struct ModeSelectionView: View {
    var user: User
    var selectedLanguage: String
    
    var body: some View {
        VStack {
            // Welcome Text
            Text("\(user.name), what would you like to practice in \(selectedLanguage)?")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            // Mode Selection Buttons
            VStack(spacing: 20) {
                NavigationLink(value: PracticeMode.numbers) {
                    ModeButtonLabel(title: "\(selectedLanguage) Numbers")
                }
                NavigationLink(value: PracticeMode.vocabulary) {
                    ModeButtonLabel(title: "\(selectedLanguage) Vocabulary")
                }
                NavigationLink(value: PracticeMode.translation) {
                    ModeButtonLabel(title: "Translate Text")
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Select Mode")
        .navigationDestination(for: PracticeMode.self) { mode in
            destinationView(for: mode)
        }
    }
    
    // Destination View Builder
    @ViewBuilder
    private func destinationView(for mode: PracticeMode) -> some View {
        switch (selectedLanguage, mode) {
        case ("English", .numbers):
            EnglishNumberView()
        case ("Korean", .numbers):
            KoreanNumberView()
        case ("Korean", .vocabulary):
            KoreanVocabularyView()
        case ("English", .vocabulary):
            EnglishVocabularyView()
        case (_, .translation):
            TranslationView()
        case ("German", .numbers):
            Text("Kommt Bald!")
        default:
            Text("Coming Soon!")
        }
    }
}

// Custom Button Style
struct ModeButtonLabel: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(Color.blue)
            .cornerRadius(12)
            .shadow(radius: 5)
            .padding(.horizontal)
    }
}
