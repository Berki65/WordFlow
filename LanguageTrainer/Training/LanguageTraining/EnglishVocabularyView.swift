import SwiftUI
import SwiftData

struct EnglishVocabularyView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \VocabularyEntry.english) private var vocabulary: [VocabularyEntry]
    @State private var currentEntry: VocabularyEntry?
    @State private var userTranslation = ""
    @State private var feedbackMessage = ""

    var body: some View {
        NavigationView {
            VStack {
                if let currentEntry = currentEntry {
                    Text("Translate the following word:")
                        .font(.headline)
                        .padding()

                    Text(currentEntry.english)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()

                    TextField("Enter your translation in Korean...", text: $userTranslation)
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
                } else {
                    Text("No vocabulary available. Please add new words.")
                        .padding()
                }

                Spacer()

                NavigationLink("Add New Word", destination: AddWordView())
                    .padding()
            }
            .padding()
            .navigationTitle("English Vocabulary")
            .onAppear {
                loadRandomWord()
            }
        }
    }

    func checkTranslation() {
        guard let currentEntry = currentEntry else { return }
        let correctAnswer = currentEntry.korean.lowercased()
        if userTranslation.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == correctAnswer {
            feedbackMessage = "Correct!"
            loadRandomWord()
        } else {
            feedbackMessage = "Try again!"
        }
    }

    func loadRandomWord() {
        if !vocabulary.isEmpty {
            currentEntry = vocabulary.randomElement()
            userTranslation = ""
            feedbackMessage = ""
        } else {
            currentEntry = nil
        }
    }
}