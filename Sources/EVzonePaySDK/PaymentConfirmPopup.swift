import SwiftUI

public struct PaymentConfirmPopup: View {
    @ObservedObject public var manager: EVzonePayManager
    
    public var body: some View {
        VStack(spacing: 0) {
            PopupHeader(showCloseButton: true, onClose: { manager.showConfirm = false })
            
            VStack(alignment: .leading, spacing: 10) {
                // Title Section
                Text("Merchant Info:")
                    .font(.system(.title3, design: .rounded, weight: .medium))
                    .foregroundColor(.primary)
                
                HStack(alignment: .top) {
                    // Left: Business Name and User ID
                    VStack(alignment: .leading, spacing: 5) {
                        Text(manager.businessName)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.primary)
                        Text(manager.userId)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    // Right: Amount
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Amount:")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.primary)
                        HStack(spacing: 0) {
                            Text(manager.currency)
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
                
                // Additional Info with Light Blue Background
                                HStack {
                                    Image(systemName: "info.circle")
                                        .foregroundColor(.blue)
                                    Text("You are making a payment to \(manager.businessName) and amount ")
                                        .font(.system(.caption, design: .rounded))
                                        .foregroundColor(.primary)
                                    +
                                    Text("\(manager.currency) \(manager.totalAmount)")
                                        .font(.system(.caption, design: .rounded))
                                        .foregroundColor(.primary) // Smooth green
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
            
            // Button: Confirm only
            Button("Confirm") { manager.proceedFromConfirm() }
                .buttonStyle(PlainButtonStyle())
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
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
