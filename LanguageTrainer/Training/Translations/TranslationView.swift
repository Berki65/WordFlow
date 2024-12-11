//
//  TranslationView.swift
//  LanguageTrainer
//
//  Created by Berkay Bentetik on 11.12.24.
//


import SwiftUI

struct TranslationView: View {
    @State private var inputText: String = ""
    @State private var translatedText: String = ""
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            TextField("Enter text to translate", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: translateText) {
                Text("Translate")
            }
            .padding()
            .disabled(isLoading)

            if isLoading {
                ProgressView()
                    .padding()
            } else {
                Text(translatedText)
                    .padding()
            }
        }
        .padding()
        .navigationTitle("Translation")
    }

    func translateText() {
        guard !inputText.isEmpty else { return }
        isLoading = true
        translatedText = ""

        let apiKey = "YOUR_API_KEY"
        let url = URL(string: "https://api.openai.com/v1/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let prompt = "Translate the following English text to \(selectedLanguage): \(inputText)"
        let parameters: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": prompt,
            "max_tokens": 100,
            "temperature": 0.3
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)

        URLSession.shared.dataTask(with: request) { data, response, error in
            defer { isLoading = false }
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let text = choices.first?["text"] as? String {
                DispatchQueue.main.async {
                    translatedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                }
            } else {
                print("Failed to parse response")
            }
        }.resume()
    }
}