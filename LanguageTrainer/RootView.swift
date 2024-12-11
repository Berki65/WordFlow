import SwiftUI
import SwiftData

struct RootView: View {
    @Query private var users: [User]
    
    var body: some View {
        if let user = users.first {
            HomeView(user: user)
        } else {
            UserSetupView()
        }
    }
}
