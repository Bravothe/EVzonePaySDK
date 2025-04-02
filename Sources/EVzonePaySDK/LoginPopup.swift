import SwiftUI

public struct LoginPopup: View {
    @ObservedObject public var manager: EVzonePayManager
    
    public var body: some View {
        VStack(spacing: 0) {
            PopupHeader()
            Divider()
                .padding(.horizontal, 20)
            Spacer()
            Text("No account detected")
                .font(.system(.title3, design: .rounded, weight: .medium))
                .foregroundColor(.primary)
            Text("Please sign in to continue")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.secondary)
                .padding(.top, 5)
            Spacer()
            Divider()
                .padding(.horizontal, 20)
            HStack(spacing: 15) {
                Button("Cancel") { manager.showLogin = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width / 2 - 35, height: 50)
                    .background(Color(.systemGray6))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                Button("Sign Up") { manager.proceedFromLogin() }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width / 2 - 35, height: 50)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .padding(.top, 10)
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 240)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
    }
    
    public init(manager: EVzonePayManager) {
        self.manager = manager
    }
}
