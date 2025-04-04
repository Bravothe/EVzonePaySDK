import SwiftUI

public struct PopupHeader: View {
    private let cloudImageURL = URL(string: "https://res.cloudinary.com/dlfa42ans/image/upload/v1743601557/logo1_ypujra.png")!
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                AsyncImage(url: cloudImageURL) { image in
                    image
                        .resizable()
                        .frame(width: 44, height: 44)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                } placeholder: {
                    ProgressView()
                        .frame(width: 44, height: 44)
                }
                Text("EVzone Pay")
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
            
            // Separator
            Divider()
                .frame(height: 1)
                .background(Color.gray.opacity(0.3))
                .overlay(
                    Rectangle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(Color.gray.opacity(0.3))
                )
                .padding(.horizontal, 20)
                .padding(.top, 10)
        }
    }
    
    public init() {}
}
