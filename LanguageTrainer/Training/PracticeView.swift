import SwiftUI

struct PracticeView: View {
    var language: String
    var mode: String

    var body: some View {
        VStack {
            Text("Practicing \(mode) in \(language)")
                .font(.largeTitle)
                .padding()

            // Add your practice content here

            Spacer()
        }
        .navigationTitle("\(language) \(mode)")
    }
}
