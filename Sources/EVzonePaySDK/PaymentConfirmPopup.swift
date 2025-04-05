import SwiftUI

public struct PaymentConfirmPopup: View {
    @ObservedObject public var manager: EVzonePayManager
    @FocusState private var isPasscodeFocused: Bool
    @State private var isCurrencyDetailsExpanded = false // State to toggle the collapsible section
    
    public var body: some View {
        VStack(spacing: 0) {
            // Header with EVzone Pay logo
            PopupHeader(showCloseButton: true, onClose: { manager.showConfirm = false })
            
            // Currency Conversion Notification
            VStack(spacing: 0) {
                // Dark Blue Section (Always Visible)
                Button(action: {
                    withAnimation {
                        isCurrencyDetailsExpanded.toggle()
                    }
                }) {
                    Text("THE RECEIVER ACCEPTS MONEY IN \(manager.ownerCurrency.uppercased()) YOU ARE ABOUT TO SEND AN EQUIVALENT OF \(manager.ownerCurrency.uppercased()) \(manager.totalAmount)")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.white)
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.blue)
                }
                
                // Light Blue Section (Collapsible)
                if isCurrencyDetailsExpanded {
                    VStack {
                        Text("Rate: \(manager.currency) 1 = \(manager.ownerCurrency) \(String(format: "%.6f", manager.exchangeRate))")
                            .font(.system(.caption, design: .rounded))
                            .foregroundColor(.primary)
                        Text("AMOUNT REQUIRED: \(manager.currency) \(manager.amountInUGX)")
                            .font(.system(.caption, design: .rounded))
                            .foregroundColor(.primary)
                        Text("(Please note: current rates and charges apply)")
                            .font(.system(.caption, design: .rounded))
                            .foregroundColor(.red)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.blue.opacity(0.1))
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            VStack(alignment: .leading, spacing: 10) {
                // Title Section
                Text("Merchant Info:")
                    .font(.system(.title3, design: .rounded, weight: .medium))
                    .foregroundColor(.primary)
                
                // Business Logo, Name, and Amount
                HStack(alignment: .top) {
                    // Left: Business Logo (Circular)
                    AsyncImage(url: URL(string: manager.businessLogoURL)) { image in
                        image
                            .resizable()
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .frame(width: 44, height: 44)
                    }
                    .padding(.trailing, 10)
                    
                    // Middle: Business Name and User ID
                    VStack(alignment: .leading, spacing: 5) {
                        Text(manager.businessName)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.primary)
                        Text(manager.userId)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    // Right: Amount (in owner's currency)
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Amount:")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.primary)
                        HStack(spacing: 0) {
                            Text(manager.ownerCurrency)
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.3)) // Smooth green
                            Text(" \(manager.totalAmount)")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.3)) // Smooth green
                        }
                    }
                }
                
                // Passcode Entry
                Text("Enter Passcode")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.top, 10)
                TextField("Enter Passcode", text: $manager.passcode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .focused($isPasscodeFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isPasscodeFocused = true
                        }
                    }
                
                // Additional Info with Light Blue Background
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                    Text("You are making a payment to \(manager.businessName) and amount ")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.primary)
                    +
                    Text("\(manager.currency) \(manager.amountInUGX)")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.3)) // Smooth green to match screenshot
                    +
                    Text(" will be deducted off your wallet, including 0.5% tax (\(manager.currency)280) and 0.5% wallet fee (\(manager.currency)500).")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.primary)
                }
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(Color.blue.opacity(0.1)) // Light blue background
                )
                .padding(.top, 10)
            }
            .padding(.horizontal, 20)
            
            // Buttons: Back and Confirm
            HStack(spacing: 10) {
                Button("Back") {
                    withAnimation(.easeInOut) {
                        manager.showConfirm = false
                        manager.showPurchase = true
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.white)
                .foregroundColor(.red)
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(Color.red, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                Button("Confirm") {
                    manager.proceedFromConfirm()
                }
                .buttonStyle(PlainButtonStyle())
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 15)
        }
        .frame(width: UIScreen.main.bounds.width - 40)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
    
    public init(manager: EVzonePayManager) {
        self.manager = manager
    }
}
