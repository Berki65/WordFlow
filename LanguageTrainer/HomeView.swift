import SwiftUI

/// The main view for the app, allowing users to select a language for study and access their profile.
struct HomeView: View {
    /// The current user of the application.
    var user: User
    
    /// A list of available languages for study, each paired with a specific color for display.
    let languages = [
        ("Korean", Color.red),
        ("English", Color.green),
        ("German", Color.blue),
        ("Spanish", Color.orange),
        ("French", Color.gray),
        ("Japanese", Color.gray),
        ("Turkish", Color.gray),
        ("Chinese", Color.gray)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // Welcome message
                    welcomeMessage
                    
                    // Language selection grid
                    languageGrid
                }
                .padding(.horizontal)
            }
            .navigationTitle("Welcome Back!") // Page title
            .toolbar {
                // Profile button in the top-right corner
                ToolbarItem(placement: .navigationBarTrailing) {
                    profileButton
                }
            }
        }
    }
}

extension HomeView {
    /// Displays a welcoming message for the user.
    private var welcomeMessage: some View {
        Text("Which language would you like to study, \(user.name)?")
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.blue)
            .multilineTextAlignment(.leading)
            .padding(.top, 25)
    }
    
    /// Displays the grid of languages available for selection.
    private var languageGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2),
            spacing: 20
        ) {
            ForEach(languages, id: \.0) { language, color in
                NavigationLink(value: language) {
                    LanguageButton(language: language, color: color)
                }
            }
        }
        .padding(.horizontal)
        .navigationDestination(for: String.self) { language in
            ModeSelectionView(user: user, selectedLanguage: language)
        }
    }
    
    /// The button to navigate to the user's profile view.
    private var profileButton: some View {
        NavigationLink(destination: UserProfileView(user: user)) {
            Image(systemName: "person.circle")
                .font(.title2)
        }
    }
}

/// A button representing a language selection option.
struct LanguageButton: View {
    /// The name of the language to display.
    let language: String
    
    /// The background color for the button.
    let color: Color
    
    var body: some View {
        VStack {
            Text(language)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
        }
        .frame(height: 100) // Fixed height for consistency
        .frame(maxWidth: .infinity) // Expand to fill available width
        .background(color)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

#Preview {
    // Preview with a sample user.
    HomeView(user: User(name: "John"))
}
