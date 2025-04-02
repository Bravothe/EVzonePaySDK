import SwiftUI

public struct PopupHeader: View {
    public let imageName: String
    
    public var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            Text("EVzone Pay")
                .font(.system(.title3, design: .rounded, weight: .semibold))
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 15)
    }
    
    public init(imageName: String) {
        self.imageName = imageName
    }
}
