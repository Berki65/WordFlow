import SwiftUI

struct KoreanVocabularyView: View {
    @State private var koreanWord = "안녕하세요" // Example word
    @State private var userTranslation = ""
    @State private var feedbackMessage = ""

    var body: some View {
        VStack {
            Text("Translate the following word:")
                .font(.headline)
                .padding()

            Text(koreanWord)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            TextField("Enter your translation...", text: $userTranslation)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onSubmit {
                    checkTranslation()
                }

            Button("Check") {
                checkTranslation()
            }
            .padding()
            .buttonStyle(.borderedProminent)

            Text(feedbackMessage)
                .font(.headline)
                .padding()
                .foregroundColor(feedbackMessage == "Correct!" ? .green : .red)

            Spacer()
        }
        .padding()
        .navigationTitle("Korean Vocabulary")
    }

    func checkTranslation() {
        if userTranslation.lowercased() == "hello" { // Example check
            feedbackMessage = "Correct!"
        } else {
            feedbackMessage = "Try again!"
        }
    }
}
