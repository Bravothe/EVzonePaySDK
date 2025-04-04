import SwiftUI

public struct PurchasePopup: View {
    @ObservedObject public var manager: EVzonePayManager
    
    public var body: some View {
        VStack(spacing: 0) {
            PopupHeader(showCloseButton: true, onClose: { manager.showPurchase = false })
            
            VStack(alignment: .center, spacing: 10) {
                // Title Section
                Text(manager.businessName)
                    .font(.system(.title2, design: .rounded, weight: .bold))
                    .foregroundColor(.primary)
                HStack(spacing: 0) {
                    Text(manager.currency)
                        .font(.system(.title2, design: .rounded, weight: .bold))
                        .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.3)) // Smooth green
                    Text(" \(manager.totalAmount)")
                        .font(.system(.title2, design: .rounded, weight: .bold))
                        .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.3)) // Smooth green
                }
                
                // Details Section
                Text("Transaction Details")
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.primary)
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Group {
                    HStack {
                        Text("Type")
                            .foregroundColor(.primary)
                        Spacer()
                        Text("Purchase")
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
                        HStack(spacing: 0) {
                            Text(manager.currency)
                                .foregroundColor(.primary)
                            Text(" \(manager.totalAmount)")
                                .foregroundColor(.primary)
                        }
                    }
                    HStack {
                        Text("Total Billing")
                            .font(.system(.body, design: .rounded, weight: .bold))
                            .foregroundColor(.primary)
                        Spacer()
                        HStack(spacing: 0) {
                            Text(manager.currency)
                                .font(.system(.body, design: .rounded, weight: .bold))
                                .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.3)) // Smooth green
                            Text(" \(manager.totalAmount)")
                                .font(.system(.body, design: .rounded, weight: .bold))
                                .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.3)) // Smooth green
                        }
                    }
                }
                .font(.system(.body, design: .rounded))
            }
            .padding(.horizontal, 20)
            
            // Button: Continue only
            Button("Continue") { manager.proceedFromPurchase() }
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
