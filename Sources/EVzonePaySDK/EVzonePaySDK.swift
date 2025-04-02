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
