import SwiftUI

public class EVzonePayManager: ObservableObject {
    @Published public var showLogin = false
    @Published public var showPurchase = false
    @Published public var showConfirm = false
    @Published public var showStatus = false
    @Published public var passcode = ""
    @Published public var paymentStatus = ""
    
    // New properties for data from the project
    public let username: String?
    public let totalAmount: String
    public let itemsPurchased: String
    
    public init(username: String?, totalAmount: String, itemsPurchased: String) {
        self.username = username
        self.totalAmount = totalAmount
        self.itemsPurchased = itemsPurchased
    }
    
    public func startPayment() {
        withAnimation(.easeInOut) {
            if username == nil {
                showLogin = true
            } else {
                showPurchase = true
            }
        }
    }
    
    // Internal methods to handle flow
    public func proceedFromLogin() {
        withAnimation(.easeInOut) {
            showLogin = false
            showPurchase = true
        }
    }
    
    public func proceedFromPurchase() {
        withAnimation(.easeInOut) {
            showPurchase = false
            showConfirm = true
        }
    }
    
    public func proceedFromConfirm(status: String) {
        withAnimation(.easeInOut) {
            showConfirm = false
            paymentStatus = status
            showStatus = true
        }
    }
    
    public func closeStatus() {
        withAnimation(.easeInOut) {
            showStatus = false
            passcode = "" // Reset passcode for next use
        }
    }
}

public let paymentMessages = [
    "Payment Successful",
    "Payment Failed",
    "Insufficient Funds"
]
