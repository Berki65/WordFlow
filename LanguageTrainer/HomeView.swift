import SwiftUI

struct HomeView: View {
    var user: User

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("Which language would you like to study, \(user.name)?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)

                HStack(spacing: 20) {
                    NavigationLink(value: "Korean") {
                        LanguageButton(language: "Korean", color: .blue)
                    }

                    NavigationLink(value: "English") {
                        LanguageButton(language: "English", color: .green)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Select Language")
            .navigationDestination(for: String.self) { language in
                ModeSelectionView(user: user, selectedLanguage: language)
            }
        }
    }
}

struct LanguageButton: View {
    let language: String
    let color: Color

    var body: some View {
        VStack {
            Text(language)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
        }
        .frame(width: 150, height: 150)
        .background(color)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}
