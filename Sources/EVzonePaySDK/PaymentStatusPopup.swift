import SwiftUI

public struct PaymentStatusPopup: View {
    @ObservedObject public var manager: EVzonePayManager
    
    public var body: some View {
        VStack(spacing: 0) {
            PopupHeader()
            Divider()
                .padding(.horizontal, 20)
            Spacer()
            Text("Payment Status")
                .font(.system(.title3, design: .rounded, weight: .medium))
                .foregroundColor(.primary)
            Text(manager.paymentStatus)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.primary)
                .padding(.top, 10)
            Spacer()
            Divider()
                .padding(.horizontal, 20)
            Button("OK") { manager.closeStatus() }
                .buttonStyle(PlainButtonStyle())
                .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
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
