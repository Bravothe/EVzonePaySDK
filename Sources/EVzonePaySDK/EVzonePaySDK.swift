import SwiftUI

public class EVzonePayManager: ObservableObject {
    @Published public var showLogin = false
    @Published public var showPurchase = false
    @Published public var showConfirm = false
    @Published public var showStatus = false
    @Published public var passcode = ""
    @Published public var paymentStatus = ""
    @Published public var isLoading = false
    
    public let username: String?
    public let userId: String
    public let businessName: String
    public let totalAmount: String // Amount in platform owner's currency (e.g., USD 5)
    public let itemsPurchased: String
    public let currency: String // User's currency (e.g., UGX)
    public let businessLogoURL: String // Business logo URL (required)
    public let ownerCurrency: String // Platform owner's currency (e.g., USD)
    public let exchangeRate: Double // Exchange rate (e.g., UGX 1 = USD 0.000027)
    public let amountInUGX: String // Equivalent amount in UGX (e.g., UGX 1000)
    
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
    
    public init(
        username: String?,
        userId: String,
        businessName: String,
        totalAmount: String,
        itemsPurchased: String,
        currency: String = "UGX",
        businessLogoURL: String,
        ownerCurrency: String,
        exchangeRate: Double,
        amountInUGX: String
    ) {
        self.username = username
        self.userId = userId
        self.businessName = businessName
        self.totalAmount = totalAmount
        self.itemsPurchased = itemsPurchased
        self.currency = currency
        self.businessLogoURL = businessLogoURL
        self.ownerCurrency = ownerCurrency
        self.exchangeRate = exchangeRate
        self.amountInUGX = amountInUGX
    }
    
    public func startPayment() {
        withAnimation(.easeInOut) {
            isLoading = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
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
    
    internal func proceedFromLogin() {
        withAnimation(.easeInOut) {
            showLogin = false
            showPurchase = true
        }
    }
    
    internal func proceedFromPurchase() {
        withAnimation(.easeInOut) {
            showPurchase = false
            showConfirm = true
        }
    }
    
    internal func proceedFromConfirm() {
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
            
            guard let balance = userBalance, let amount = Double(amountInUGX.replacingOccurrences(of: currency, with: "").trimmingCharacters(in: .whitespaces)) else {
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
    
    internal func closeStatus() {
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
