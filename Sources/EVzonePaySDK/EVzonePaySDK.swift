import SwiftUI

public class EVzonePayManager: ObservableObject {
    @Published public var showLogin = false
    @Published public var showPurchase = false
    @Published public var showConfirm = false
    @Published public var showStatus = false
    @Published public var passcode = ""
    @Published public var paymentStatus = ""
    @Published public var isLoading = false // New loading state
    
    public let username: String?
    public let totalAmount: String
    public let itemsPurchased: String
    
    private let users: [String: (passcode: String, balance: Double)] = [
        "user1": ("1234", 150.00),
        "user2": ("5678", 50.00)
    ]
    
    public var storedPasscode: String? {
        username != nil ? users[username!]?.passcode : nil
    }
    public var userBalance: Double? {
        username != nil ? users[username!]?.balance : nil
    }
    
    public init(username: String?, totalAmount: String, itemsPurchased: String) {
        self.username = username
        self.totalAmount = totalAmount
        self.itemsPurchased = itemsPurchased
    }
    
    public func startPayment() {
        withAnimation(.easeInOut) {
            isLoading = true
        }
        // Simulate a network delay for loading (replace with actual check if needed)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut) {
                self.isLoading = false
                if self.username == nil || self.users[self.username!] == nil {
                    self.showLogin = true
                } else {
                    self.showPurchase = true
                }
            }
        }
    }
    
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
    
    public func proceedFromConfirm() {
        withAnimation(.easeInOut) {
            guard let storedPasscode = storedPasscode else {
                paymentStatus = "Payment Failed"
                showConfirm = false
                showStatus = true
                return
            }
            
            if passcode != storedPasscode {
                paymentStatus = "Payment Failed"
                showConfirm = false
                showStatus = true
                return
            }
            
            guard let balance = userBalance, let amount = Double(totalAmount.replacingOccurrences(of: "$", with: "")) else {
                paymentStatus = "Payment Failed"
                showConfirm = false
                showStatus = true
                return
            }
            
            if balance >= amount {
                paymentStatus = "Payment Successful"
            } else {
                paymentStatus = "Insufficient Funds"
            }
            
            showConfirm = false
            showStatus = true
        }
    }
    
    public func closeStatus() {
        withAnimation(.easeInOut) {
            showStatus = false
            passcode = ""
        }
    }
}

public let paymentMessages = [
    "Payment Successful",
    "Payment Failed",
    "Insufficient Funds"
]
