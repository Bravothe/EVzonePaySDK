import SwiftUI

public struct PaymentConfirmPopup: View {
    @ObservedObject public var manager: EVzonePayManager
    
    public var body: some View {
        VStack(spacing: 0) {
            PopupHeader()
            VStack(alignment: .leading, spacing: 10) {
                // Title Section
                HStack {
                    Text("Merchant Info: ")
                        .font(.system(.title3, design: .rounded, weight: .medium))
                        .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.3))
                    Text(manager.businessName)
                        .font(.system(.title3, design: .rounded, weight: .medium))
                        .foregroundColor(.primary)
                    Spacer()
                    HStack(spacing: 0) {
                        Text("Amount: ")
                            .font(.system(.title3, design: .rounded, weight: .medium))
                            .foregroundColor(.primary)
                        Text(manager.currency)
                            .font(.system(.title3, design: .rounded, weight: .medium))
                            .foregroundColor(.primary)
                        Text(" \(manager.totalAmount)")
                            .font(.system(.title3, design: .rounded, weight: .medium))
                            .foregroundColor(.primary) 
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
                
                // Additional Info
                HStack {
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                    Text("You are making a payment to \(manager.businessName) and amount ")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.primary)
                    +
                    Text("\(manager.currency) \(manager.totalAmount)")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.3)) // Smooth green
                    +
                    Text(" will be deducted off your wallet, including 0.5% tax (\(manager.currency)280) and 0.5% wallet fee (\(manager.currency)500).")
                        .font(.system(.caption, design: .rounded))
                        .foregroundColor(.primary)
                }
                .padding(.top, 10)
            }
            .padding(.horizontal, 20)
            
            // Buttons: Cancel and Confirm
            HStack(spacing: 15) {
                Button("Cancel") { manager.showConfirm = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                Button("Confirm") { manager.proceedFromConfirm() }
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
