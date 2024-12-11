import SwiftUI
import Translation

struct TranslationView: View {
    @State private var sourceLanguage: String = "English"
    @State private var targetLanguage: String = "Korean"
    @State private var isReversed: Bool = false
    @State private var arrowRotation: Double = 0
    @State private var inputText: String = ""
    @State private var translatedText: String = "Translated text will appear here."

    let availableLanguages = [
        "Korean", "English", "German", "Spanish",
        "French", "Japanese", "Turkish", "Chinese"
    ]

    var body: some View {
        VStack(spacing: 30) {
            HStack {
                // Source Language Picker
                Picker("Source Language", selection: $sourceLanguage) {
                    ForEach(availableLanguages, id: \.self) { language in
                        Text(language)
                            .tag(language)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )

                // Animated Arrow Button
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        swapLanguages()
                        arrowRotation += 180
                    }
                }) {
                    Image(systemName: "arrow.left.arrow.right.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(arrowRotation))
                        .scaleEffect(isReversed ? 1.1 : 1.0)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isReversed)
                }

                // Target Language Picker
                Picker("Target Language", selection: $targetLanguage) {
                    ForEach(availableLanguages, id: \.self) { language in
                        Text(language)
                            .tag(language)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.green, lineWidth: 1)
                )
            }
            .padding()


            VStack(spacing: 20) {
                Text("Translation result:")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Output Text (read-only)
                Text("비밀번호")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                Text("Enter text to translate:")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Input Text Field
                TextField("Type here...", text: $inputText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }
            .padding()

            // Translate Button
            Button(action: translateText) {
                Text("Translate")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
            .padding()

            Spacer()
        }
        .padding()
//        .navigationTitle("Translate Text")
    }

    private func swapLanguages() {
        isReversed.toggle()
        (sourceLanguage, targetLanguage) = (targetLanguage, sourceLanguage)
    }

    private func translateText() {
        // Placeholder translation logic
        // Replace this with actual translation API logic
        translatedText = "\(inputText) translated to \(targetLanguage)"
    }
}

#Preview {
    TranslationView()
}
