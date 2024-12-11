//import SwiftUI
//import SwiftData
//
//struct AddWordView: View {
//    @Environment(\.modelContext) private var context
//    @Environment(\.dismiss) private var dismiss
//    @State private var koreanWord = ""
//    @State private var englishTranslation = ""
//
//    var body: some View {
//        Form {
//            Section(header: Text("New Vocabulary")) {
//                TextField("Korean Word", text: $koreanWord)
//                TextField("English Translation", text: $englishTranslation)
//            }
//
//            Button("Add Word") {
//                addWord()
//            }
//            .disabled(koreanWord.isEmpty || englishTranslation.isEmpty)
//        }
//        .navigationTitle("Add New Word")
//    }
//
//    func addWord() {
//        let newEntry = VocabularyEntry(korean: koreanWord, english: englishTranslation)
//        context.insert(newEntry)
//        dismiss()
//    }
//}
