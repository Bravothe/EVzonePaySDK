import SwiftUI

public class EVzonePayManager: ObservableObject {
    @Published public var showLogin = false
    @Published public var showPurchase = false
    @Published public var showConfirm = false
    @Published public var showStatus = false
    @Published public var passcode = ""
    @Published public var paymentStatus = ""
    
    // Data from the project
    public let username: String?
    public let totalAmount: String
    public let itemsPurchased: String
    
    // Internal user data (simulated database)
    private let users: [String: (passcode: String, balance: Double)] = [
        "user1": ("1234", 150.00),
        "user2": ("5678", 50.00)
    ]
    
    private var storedPasscode: String? {
        username != nil ? users[username!]?.passcode : nil
    }
    private var userBalance: Double? {
        username != nil ? users[username!]?.balance : nil
    }
    
    public init(username: String?, totalAmount: String, itemsPurchased: String) {
        self.username = username
        self.totalAmount = totalAmount
        self.itemsPurchased = itemsPurchased
    }
    
    public func startPayment() {
        withAnimation(.easeInOut) {
            if username == nil || users[username!] == nil {
                showLogin = true // No username or invalid username
            } else {
                showPurchase = true // Valid username, proceed to purchase
            }
        }
    }
    
    // Internal flow methods
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
            passcode = "" // Reset passcode
        }
    }
}

public let paymentMessages = [
    "Payment Successful",
    "Payment Failed",
    "Insufficient Funds"
]
