import SwiftUI

public struct EVzonePayView: View {
    @ObservedObject public var manager: EVzonePayManager
    @State private var isBlinking = false // For text blinking
    
    private let logoURL = URL(string: "https://res.cloudinary.com/dlfa42ans/image/upload/v1741686201/logo_n7vrsf.jpg")!
    
    public var body: some View {
        ZStack {
            if manager.isLoading {
                VStack {
                    AsyncImage(url: logoURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    } placeholder: {
                        ProgressView()
                            .frame(width: 44, height: 44)
                    }
                    HStack(spacing: 0) {
                        Text("EVzone")
                            .font(.system(.body, design: .rounded, weight: .bold))
                            .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.3)) // Smooth green
                        Text(" Pay")
                            .font(.system(.body, design: .rounded, weight: .bold))
                            .foregroundColor(Color(red: 1.0, green: 0.5, blue: 0.0)) // Smooth orange
                        
                    }
                    .padding(.top, 10)
                    .opacity(isBlinking ? 1.0 : 0.0) // Blinking effect
                    .animation(
                        Animation.easeInOut(duration: 1.0)
                            .repeatForever(autoreverses: true),
                        value: isBlinking
                    )
                    .onAppear { isBlinking = true }
                    .onDisappear { isBlinking = false }
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
