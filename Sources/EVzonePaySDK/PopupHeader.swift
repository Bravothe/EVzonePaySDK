//
import SwiftUI

public struct PopupHeader: View {
    private let cloudImageURL = URL(string: "https://res.cloudinary.com/dlfa42ans/image/upload/v1743601557/logo1_ypujra.png")!
    
    public var body: some View {
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
    }
    
    public init() {}
}
