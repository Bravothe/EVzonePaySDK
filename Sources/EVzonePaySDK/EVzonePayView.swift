import SwiftUI

public struct EVzonePayView: View {
    @ObservedObject public var manager: EVzonePayManager
    @State private var isBlinking = false
    
    private let logoURL = URL(string: "https://res.cloudinary.com/dlfa42ans/image/upload/v1743601557/logo1_ypujra.png")!
    
    public var body: some View {
        ZStack {
            if manager.isLoading {
                VStack {
                    AsyncImage(url: logoURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60) // Increased from 44x44 to 60x60
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 60, height: 60) // Increased from 44x44 to 60x60
                    }
                    HStack(spacing: 0) {
                        Text("EVzone")
                            .font(.system(.title2, design: .rounded, weight: .bold)) // Increased from .body to .title2
                            .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.3)) // Smooth green
                        Text(" Pay")
                            .font(.system(.title2, design: .rounded, weight: .bold)) // Increased from .body to .title2
                            .foregroundColor(Color(red: 1.0, green: 0.5, blue: 0.0)) // Smooth orange
                    }
                    .padding(.top, 10)
                    .opacity(isBlinking ? 1.0 : 0.0)
                    .animation(
                        Animation.easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                        value: isBlinking
                    )
                    .onAppear { isBlinking = true }
                    .onDisappear { isBlinking = false }
                }
                .frame(width: UIScreen.main.bounds.width - 40, height: 250) // Increased from 150x150 to match other popups
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
