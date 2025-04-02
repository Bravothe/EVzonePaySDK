import SwiftUI

public struct EVzonePayView: View {
    @ObservedObject public var manager: EVzonePayManager
    
    public var body: some View {
        ZStack {
            if manager.isLoading {
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                    Text("Processing...")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.secondary)
                        .padding(.top, 10)
                }
                .frame(width: 150, height: 150)
                .background(Color(.systemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
                .transition(.scale.combined(with: .opacity))
            }
            
            if manager.showLogin {
                LoginPopup(manager: manager)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.8).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
            }
            
            if manager.showPurchase {
                PurchasePopup(manager: manager)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.8).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
            }
            
            if manager.showConfirm {
                PaymentConfirmPopup(manager: manager)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.8).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
            }
            
            if manager.showStatus {
                PaymentStatusPopup(manager: manager)
                    .transition(.asymmetric(
                        insertion: .scale(scale: 0.8).combined(with: .opacity),
                        removal: .move(edge: .bottom).combined(with: .opacity)
                    ))
            }
        }
    }
    
    public init(manager: EVzonePayManager) {
        self.manager = manager
    }
}
