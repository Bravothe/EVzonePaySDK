import SwiftUI

public struct PaymentStatusPopup: View {
    @ObservedObject public var manager: EVzonePayManager
    
    public var body: some View {
        VStack(spacing: 0) {
            PopupHeader()
            VStack(spacing: 15) {
                // Status Icon
                if manager.paymentStatus == "Insufficient Funds" {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.orange)
                } else if manager.paymentStatus == "Payment Successful" {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue) // Changed to blue
                } else if manager.paymentStatus == "Payment Failed" {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.red)
                }
                
                // Status Title
                Text(manager.paymentStatus == "Payment Failed" ? "Transaction Failed" : manager.paymentStatus)
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .foregroundColor(
                        manager.paymentStatus == "Insufficient Funds" ? .orange :
                        manager.paymentStatus == "Payment Successful" ? .blue :
                        manager.paymentStatus == "Payment Failed" ? .red : .primary
                    )
                    .multilineTextAlignment(.center)
                
                // Status Message
                if manager.paymentStatus == "Insufficient Funds" {
                    Text("The account did not have sufficient funds to cover the transaction amount at the time of the transaction")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                } else if manager.paymentStatus == "Payment Failed" {
                    Text("Please check your wallet for details")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                // No message for Payment Successful
                
                // Button
                Button(action: {
                    if manager.paymentStatus == "Insufficient Funds" {
                        // In a real app, this would navigate to a funding screen
                        manager.closeStatus() // For now, just close
                    } else if manager.paymentStatus == "Payment Failed" {
                        // In a real app, this would navigate to a details screen
                        manager.closeStatus() // For now, just close
                    } else {
                        manager.closeStatus()
                    }
                }) {
                    Text(
                        manager.paymentStatus == "Insufficient Funds" ? "Add Funds" :
                        manager.paymentStatus == "Payment Successful" ? "Done" :
                        manager.paymentStatus == "Payment Failed" ? "Details" : "OK"
                    )
                    .font(.system(.body, design: .rounded, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        manager.paymentStatus == "Payment Failed" ? Color.red : Color.blue
                    )
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 20)
        }
        .frame(width: UIScreen.main.bounds.width - 40)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
    
    public init(manager: EVzonePayManager) {
        self.manager = manager
    }
}
