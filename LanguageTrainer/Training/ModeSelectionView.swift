import SwiftUI

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
                // Mode Selection Buttons
                NavigationLink(destination: PracticeView(language: selectedLanguage, mode: "Numbers")) {
                    ModeButtonLabel(title: "\(selectedLanguage) Numbers")
                }

                NavigationLink(destination: PracticeView(language: selectedLanguage, mode: "Vocabulary")) {
                    ModeButtonLabel(title: "\(selectedLanguage) Vocabulary")
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Select Mode")
    }
}

// Reusable Mode Button Label
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
    }
}
