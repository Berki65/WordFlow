import SwiftUI
import SwiftData

struct UserProfileView: View {
    @Environment(\.modelContext) private var context
    @State private var isEditing = false
    @Bindable var user: User

    var body: some View {
        VStack {
            if isEditing {
                // Editing Mode: User can update their name
                TextField("Enter new name", text: $user.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Action Buttons: Cancel and Save
                HStack {
                    Button("Cancel") {
                        isEditing = false
                    }
                    .padding()

                    Button("Save") {
                        saveChanges()
                        isEditing = false
                    }
                    .padding()
                }
            } else {
                // Display Mode: Show user's profile details
                Text("Account Details for \(user.name)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                // Edit Button: Switch to editing mode
                Button("Edit Name") {
                    isEditing = true
                }
                .padding()
            }
            Spacer()
        }
        .navigationTitle("Profile")
    }

    // Save Changes to the Context
    private func saveChanges() {
        do {
            try context.save()
        } catch {
            print("Error saving changes: \(error)")
        }
    }
}

#Preview {
    UserProfileView(user: User(name: "John"))
}
