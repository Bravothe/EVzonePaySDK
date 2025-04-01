import SwiftUI
import UIKit // For UIScreen
import Combine // For @Published

// Public SDK Manager
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

// Payment Status Messages
public let paymentMessages = [
    "Payment Successful",
    "Payment Failed",
    "Insufficient Funds"
]

// Header View with Consumer-Provided Image
public struct PopupHeader: View {
    public let imageName: String
    
    public var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(8)
            Text("EVzone Pay")
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    public init(imageName: String) {
        self.imageName = imageName
    }
}

// Popup Views
public struct LoginPopup: View {
    @Binding public var shown: Bool
    public let imageName: String
    public let onLogin: () -> Void
    
    public var body: some View {
        VStack {
            PopupHeader(imageName: imageName)
            Spacer()
            Text("Please Login")
                .font(.subheadline)
                .foregroundColor(.white)
            Spacer()
            HStack {
                Button("Cancel") { shown = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width/2-25, height: 40)
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Button("Login") {
                    withAnimation(.easeInOut) { onLogin() }
                }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width/2-25, height: 40)
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.bottom, 15)
        }
        .frame(width: UIScreen.main.bounds.width-50, height: 200)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.blue.opacity(0.6)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(12)
        .shadow(radius: 5)
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
        VStack {
            PopupHeader(imageName: imageName)
            Spacer()
            Text("Purchase Details")
                .font(.subheadline)
                .foregroundColor(.white)
            Text("Item: Premium Subscription")
                .foregroundColor(.white.opacity(0.9))
            Text("Price: $9.99")
                .foregroundColor(.white.opacity(0.9))
            Spacer()
            HStack {
                Button("Cancel") { shown = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width/2-25, height: 40)
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Button("Next") {
                    withAnimation(.easeInOut) { onNext() }
                }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width/2-25, height: 40)
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.bottom, 15)
        }
        .frame(width: UIScreen.main.bounds.width-50, height: 200)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.blue.opacity(0.6)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(12)
        .shadow(radius: 5)
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
        VStack {
            PopupHeader(imageName: imageName)
            Spacer()
            Text("Payment Confirmation")
                .font(.subheadline)
                .foregroundColor(.white)
            Text("Amount: $9.99")
                .foregroundColor(.white.opacity(0.9))
            Text("Service Fee: $0.50")
                .foregroundColor(.white.opacity(0.9))
            Text("Total: $10.49")
                .foregroundColor(.white.opacity(0.9))
            TextField("Enter Passcode", text: $passcode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 200)
                .background(Color.white.opacity(0.1))
            Spacer()
            HStack {
                Button("Cancel") { shown = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width/2-25, height: 40)
                    .background(Color.red.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Button("Continue") {
                    withAnimation(.easeInOut) {
                        let randomStatus = Int.random(in: 0...2)
                        onConfirm(paymentMessages[randomStatus])
                    }
                }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: UIScreen.main.bounds.width/2-25, height: 40)
                    .background(Color.blue.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.bottom, 15)
        }
        .frame(width: UIScreen.main.bounds.width-50, height: 250)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.blue.opacity(0.6)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(12)
        .shadow(radius: 5)
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
        VStack {
            PopupHeader(imageName: imageName)
            Spacer()
            Text("Payment Status")
                .font(.subheadline)
                .foregroundColor(.white)
            Text(status)
                .foregroundColor(.white.opacity(0.9))
            Spacer()
            Button("OK") { shown = false }
                .buttonStyle(PlainButtonStyle())
                .frame(width: UIScreen.main.bounds.width/2-25, height: 40)
                .background(Color.blue.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.bottom, 15)
        }
        .frame(width: UIScreen.main.bounds.width-50, height: 200)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.blue.opacity(0.6)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(12)
        .shadow(radius: 5)
    }
    
    public init(shown: Binding<Bool>, status: Binding<String>, imageName: String) {
        self._shown = shown
        self._status = status
        self.imageName = imageName
    }
}
