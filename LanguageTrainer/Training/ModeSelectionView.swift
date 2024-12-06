import SwiftUI

enum PracticeMode: Hashable {
    case numbers
    case vocabulary
}

struct ModeSelectionView: View {
    var user: User
    var selectedLanguage: String

    var body: some View {
        VStack {
            Text("\(user.name), what would you like to practice in \(selectedLanguage)?")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            VStack(spacing: 20) {
                // NavigationLink for Numbers
                NavigationLink(value: PracticeMode.numbers) {
                    ModeButtonLabel(title: "\(selectedLanguage) Numbers")
                }

                // NavigationLink for Vocabulary
                NavigationLink(value: PracticeMode.vocabulary) {
                    ModeButtonLabel(title: "\(selectedLanguage) Vocabulary")
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

    @ViewBuilder
    private func destinationView(for mode: PracticeMode) -> some View {
        switch (selectedLanguage, mode) {
        case ("English", .numbers):
            EnglishNumberView()
        case ("Korean", .numbers):
            KoreanNumberView()
        case ("Korean", .vocabulary):
            Text("Vocabulary Practice Coming Soon!") // Placeholder
        default:
            Text("Coming Soon!")
        }
    }
}

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
