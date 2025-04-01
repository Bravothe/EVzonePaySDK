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
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            Text("EVzone Pay")
                .font(.system(.title3, design: .rounded, weight: .semibold))
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 15)
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
        VStack(spacing: 0) {
            PopupHeader(imageName: imageName)
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
                Button("Cancel") { shown = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width / 2 - 35, height: 50)
                    .background(Color(.systemGray6))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                Button("Sign Up") {
                    withAnimation(.easeInOut) { onLogin() }
                }
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
        VStack(spacing: 0) {
            PopupHeader(imageName: imageName)
            Divider()
                .padding(.horizontal, 20)
            Spacer()
            Text("Purchase Details")
                .font(.system(.title3, design: .rounded, weight: .medium))
                .foregroundColor(.primary)
            VStack(spacing: 8) {
                Text("Premium Subscription")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.primary)
                Text("Price: $9.99")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.secondary)
            }
            .padding(.top, 10)
            Spacer()
            Divider()
                .padding(.horizontal, 20)
            HStack(spacing: 15) {
                Button("Cancel") { shown = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width / 2 - 35, height: 50)
                    .background(Color(.systemGray6))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                Button("Next") {
                    withAnimation(.easeInOut) { onNext() }
                }
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
        .frame(width: UIScreen.main.bounds.width - 40, height: 260)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
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
        VStack(spacing: 0) {
            PopupHeader(imageName: imageName)
            Divider()
                .padding(.horizontal, 20)
            Spacer()
            Text("Payment Confirmation")
                .font(.system(.title3, design: .rounded, weight: .medium))
                .foregroundColor(.primary)
            Text("Amount: $9.99  •  Service Fee: $0.50  •  Total: $10.49")
                .font(.system(.body, design: .rounded))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            TextField("Enter Passcode", text: $passcode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 220, height: 44)
                .padding(.top, 15)
            Spacer()
            Divider()
                .padding(.horizontal, 20)
            HStack(spacing: 15) {
                Button("Cancel") { shown = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width / 2 - 35, height: 50)
                    .background(Color(.systemGray6))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                
                Button("Continue") {
                    withAnimation(.easeInOut) {
                        let randomStatus = Int.random(in: 0...2)
                        onConfirm(paymentMessages[randomStatus])
                    }
                }
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
        .frame(width: UIScreen.main.bounds.width - 40, height: 300)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
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
        VStack(spacing: 0) {
            PopupHeader(imageName: imageName)
            Divider()
                .padding(.horizontal, 20)
            Spacer()
            Text("Payment Status")
                .font(.system(.title3, design: .rounded, weight: .medium))
                .foregroundColor(.primary)
            Text(status)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.primary)
                .padding(.top, 10)
            Spacer()
            Divider()
                .padding(.horizontal, 20)
            Button("OK") { shown = false }
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
    
    public init(shown: Binding<Bool>, status: Binding<String>, imageName: String) {
        self._shown = shown
        self._status = status
        self.imageName = imageName
    }
}
