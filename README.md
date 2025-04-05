
# EVzonePaySDK

A SwiftUI-based iOS SDK for integrating EVzone Pay payment flow into your E-commerce platform.

## Features

- **Customizable**: Pass your own `businessName`, `userId`, `username` (buyer details), `totalAmount`, `itemsPurchased`, `currency`, `businessLogoURL`, `ownerCurrency`, `exchangeRate`, and `amountInUGX`.
- **Currency Conversion**: Supports payments in the platform owner’s currency (e.g., USD) with automatic conversion from the user’s currency (e.g., UGX), including a notification with exchange rate details.

## Requirements

- iOS 16.0 or later
- Swift 5.5+
- Xcode 13.0+

## Installation

### Swift Package Manager

1. In Xcode, go to `File > Add Packages`.
2. Enter the repository URL:
   ```swift
   https://github.com/Bravothe/EVzonePaySDK.git
   ```
3. Add the package to your target.

## Usage

### Quick Start

1. **Import the SDK**:
   ```swift
   import EVzonePaySDK
   ```

2. **Set Up in Your View**:

   Create an instance of `EVzonePayManager` with your payment details, add a button to initiate the payment flow, and embed `EVzonePayView` to display the payment UI. The SDK will handle the payment flow accordingly as long as you have passed the required variables correctly.

   **Note**: The `businessLogoURL` parameter is required and must be a valid URL pointing to the business logo (e.g., hosted on Cloudinary). The `totalAmount` should be in the platform owner’s currency (e.g., USD), and you must provide the `ownerCurrency`, `exchangeRate`, and `amountInUGX` for currency conversion.

   ```swift
   import SwiftUI
   import EVzonePaySDK

   struct ContentView: View {
       @StateObject private var payManager: EVzonePayManager
       
       init() {
           _payManager = StateObject(wrappedValue: EVzonePayManager(
               username: "user1",
               userId: "W-123456789",
               businessName: "Acorns International School",
               totalAmount: "5", // Amount in platform owner's currency (USD)
               itemsPurchased: "School Fees",
               currency: "UGX", // User's currency
               businessLogoURL: "https://res.cloudinary.com/dlfa42ans/image/upload/v1743601557/logo1_ypujra.png", // Replace with actual Cloudinary URL
               ownerCurrency: "USD", // Platform owner's currency
               exchangeRate: 0.000027, // Exchange rate (UGX 1 = USD 0.000027)
               amountInUGX: "1000" // Equivalent amount in user's currency (UGX)
           ))
       }
       
       var body: some View {
           ZStack {
               VStack {
                   VStack(alignment: .leading, spacing: 10) {
                       Text("Item: \(payManager.itemsPurchased)")
                           .font(.headline)
                       Text("Total Amount: \(payManager.ownerCurrency) \(payManager.totalAmount)")
                           .font(.headline)
                   }
                   .padding()
                   
                   Button("Pay Now") {
                       payManager.startPayment()
                   }
                   .buttonStyle(PlainButtonStyle())
                   .frame(width: 200, height: 50)
                   .background(Color.blue)
                   .foregroundColor(.white)
                   .cornerRadius(10)
                   
                   Spacer()
               }
               
               EVzonePayView(manager: payManager)
           }
       }
   }

   struct ContentView_Previews: PreviewProvider {
       static var previews: some View {
           ContentView()
       }
   }
   ```

## License

MIT License. See [LICENSE](LICENSE) for details.



