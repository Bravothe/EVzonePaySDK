import SwiftUI

public class EVzonePayManager: ObservableObject {
    @Published public var showLogin = false
    @Published public var showPurchase = false
    @Published public var showConfirm = false
    @Published public var showStatus = false
    @Published public var passcode = ""
    @Published public var paymentStatus = ""
    
    public init() {}
    
    public func startPaymentFlow(username: String?) {
        withAnimation(.easeInOut) {
            showLogin = username == nil
            showPurchase = username != nil
        }
    }
}

public let paymentMessages = [
    "Payment Successful",
    "Payment Failed",
    "Insufficient Funds"
]

public struct PopupHeader: View {
    public let imageName: String
    
    public var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            Text("EVzone Pay")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    public init(imageName: String) {
        self.imageName = imageName
    }
}

public struct LoginPopup: View {
    @Binding public var shown: Bool
    public let imageName: String
    public let onLogin: () -> Void
    
    public var body: some View {
        VStack(spacing: 20) {
            PopupHeader(imageName: imageName)
            Spacer()
            Text("No account detected, please sign in to continue")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
            HStack(spacing: 10) {
                Button("Cancel") { shown = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 40)
                    .background(Color(.systemGray5))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                Button("Sign Up") {
                    withAnimation(.easeInOut) { onLogin() }
                }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 40)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding(.bottom, 15)
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 200)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 14, style: .continuous)
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    public init(shown: Binding<Bool>, imageName: String, onLogin: @escaping () -> Void) {
        self._shown = shown
        self.imageName = imageName
        self.onLogin = onLogin
    }
}

public struct PurchasePopup: View {
    @Binding public var shown: Bool
    public let imageName: String
    public let onNext: () -> Void
    
    public var body: some View {
        VStack(spacing: 20) {
            PopupHeader(imageName: imageName)
            Spacer()
            Text("Purchase Details")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.secondary)
            Text("Premium Subscription")
                .font(.system(.body, design: .rounded))
                .foregroundColor(.primary)
            Text("Price: $9.99")
                .font(.system(.body, design: .rounded))
                .foregroundColor(.primary)
            Spacer()
            HStack(spacing: 10) {
                Button("Cancel") { shown = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 40)
                    .background(Color(.systemGray5))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                Button("Next") {
                    withAnimation(.easeInOut) { onNext() }
                }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 40)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding(.bottom, 15)
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 200)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 14, style: .continuous)
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    public init(shown: Binding<Bool>, imageName: String, onNext: @escaping () -> Void) {
        self._shown = shown
        self.imageName = imageName
        self.onNext = onNext
    }
}

public struct PaymentConfirmPopup: View {
    @Binding public var shown: Bool
    @Binding public var passcode: String
    public let imageName: String
    public let onConfirm: (String) -> Void
    
    public var body: some View {
        VStack(spacing: 20) {
            PopupHeader(imageName: imageName)
            Spacer()
            Text("Payment Confirmation")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.secondary)
            Text("Amount: $9.99  Service Fee: $0.50  Total: $10.49")
                .font(.system(.headline, design: .rounded))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            TextField("Enter Passcode", text: $passcode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 200)
                .padding(.vertical, 5)
            Spacer()
            HStack(spacing: 10) {
                Button("Cancel") { shown = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 40)
                    .background(Color(.systemGray5))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                Button("Continue") {
                    withAnimation(.easeInOut) {
                        let randomStatus = Int.random(in: 0...2)
                        onConfirm(paymentMessages[randomStatus])
                    }
                }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 40)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding(.bottom, 15)
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 250)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 14, style: .continuous)
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    public init(shown: Binding<Bool>, passcode: Binding<String>, imageName: String, onConfirm: @escaping (String) -> Void) {
        self._shown = shown
        self._passcode = passcode
        self.imageName = imageName
        self.onConfirm = onConfirm
    }
}

public struct PaymentStatusPopup: View {
    @Binding public var shown: Bool
    @Binding public var status: String
    public let imageName: String
    
    public var body: some View {
        VStack(spacing: 20) {
            PopupHeader(imageName: imageName)
            Spacer()
            Text("Payment Status")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(.secondary)
            Text(status)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.primary)
            Spacer()
            Button("OK") { shown = false }
                .buttonStyle(PlainButtonStyle())
                .frame(width: UIScreen.main.bounds.width / 2 - 25, height: 40)
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding(.bottom, 15)
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 200)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 14, style: .continuous)
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    public init(shown: Binding<Bool>, status: Binding<String>, imageName: String) {
        self._shown = shown
        self._status = status
        self.imageName = imageName
    }
}
