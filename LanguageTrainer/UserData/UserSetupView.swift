import SwiftUI
import SwiftData

struct UserSetupView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var userName: String = ""
    @State private var isUserSaved: Bool = false

    var body: some View {
        ZStack {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)

            VStack {
                VStack(spacing: 10) {
                    Text("Welcome to Language Trainer!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top, 40)

                    Text("Please let me know your name so we can get started!")
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top, 60)
                }
                .frame(maxWidth: .infinity, alignment: .top)

                Spacer()

                TextField("Enter your name", text: $userName)
                    .foregroundStyle(.primary)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)
                    .padding(.bottom, 200)

                Spacer()

                Button(action: {
                    saveUserName(name: userName)
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.horizontal, 40)
                }
                .disabled(userName.isEmpty)
                .opacity(userName.isEmpty ? 0.6 : 1)
                .padding(.bottom, 40)
            }
        }
        .fullScreenCover(isPresented: $isUserSaved) {
            HomeView(user: User(name: userName))
        }
    }

    private func saveUserName(name: String) {
        let user = User(name: name)
        modelContext.insert(user)
        do {
            try modelContext.save()
            print("User name saved: \(name)")
            isUserSaved = true
        } catch {
            print("Failed to save user name: \(error)")
        }
    }
}
