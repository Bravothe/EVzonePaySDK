import SwiftUI

public struct PurchasePopup: View {
    @ObservedObject public var manager: EVzonePayManager
    
    public var body: some View {
        VStack(spacing: 0) {
            PopupHeader()
            VStack(alignment: .leading, spacing: 10) {
                // Title Section
                Text(manager.businessName)
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .foregroundColor(.primary)
                Text("\(manager.currency) \(manager.totalAmount)")
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .foregroundColor(.primary)
                
                // Details Section
                Text("Transaction Details")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.top, 10)
                
                Group {
                    HStack {
                        Text("Type")
                            .foregroundColor(.primary)
                        Spacer()
                        Text("Booking")
                            .foregroundColor(.primary)
                    }
                    HStack {
                        Text("To")
                            .foregroundColor(.primary)
                        Spacer()
                        Text(manager.userId)
                            .foregroundColor(.primary)
                    }
                    HStack {
                        Text("Particulars")
                            .foregroundColor(.primary)
                        Spacer()
                        Text(manager.itemsPurchased)
                            .foregroundColor(.primary)
                    }
                    HStack {
                        Text("Billed Currency")
                            .foregroundColor(.primary)
                        Spacer()
                        Text(manager.currency)
                            .foregroundColor(.primary)
                    }
                    HStack {
                        Text("Billed Amount")
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(manager.currency) \(manager.totalAmount)")
                            .foregroundColor(.primary)
                    }
                    HStack {
                        Text("Total Billing")
                            .font(.system(.body, design: .rounded, weight: .bold))
                            .foregroundColor(.primary)
                        Spacer()
                        Text("\(manager.currency) \(manager.totalAmount)")
                            .font(.system(.body, design: .rounded, weight: .bold))
                            .foregroundColor(.primary)
                    }
                }
                .font(.system(.body, design: .rounded))
            }
            .padding(.horizontal, 20)
            
            // Buttons: Cancel and Next
            HStack(spacing: 15) {
                Button("Cancel") { manager.showPurchase = false }
                    .buttonStyle(PlainButtonStyle())
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(.systemGray6))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                Button("Next") { manager.proceedFromPurchase() }
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
