
# EVzonePaySDK

A SwiftUI-based iOS SDK for integrating a simple payment flow into your app. This SDK handles user authentication, purchase confirmation, and payment status display through elegant popups, requiring minimal setup from the consumer app.

## Features

- User Validation: Checks if a username exists before proceeding.
- Passcode Verification: Ensures the entered passcode matches the stored one.
- Balance Check: Confirms sufficient funds for the transaction.
- Popup UI: Provides a complete payment flow with Login, Purchase, Confirmation, and Status popups, with a cloud-hosted logo and animated loading state.
- Customizable: Pass your own username, total amount, and items purchased.

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

1. Import the SDK:
   ```swift
   import EVzonePaySDK
   ```

2. Set Up in Your View:

   Create an instance of `EVzonePayManager` with your payment details and add `EVzonePayView` to your view hierarchy.

   ```swift
   import SwiftUI
   import EVzonePaySDK

   struct ContentView: View {
       @StateObject private var payManager: EVzonePayManager
       
       init() {
           _payManager = StateObject(wrappedValue: EVzonePayManager(
               username: "user1",
               totalAmount: "$100.49",
               itemsPurchased: "Premium Subscription"
           ))
       }
       
       var body: some View {
           ZStack {
               VStack {
                   VStack(alignment: .leading, spacing: 10) {
                       Text("Item: \(payManager.itemsPurchased)")
                           .font(.headline)
                       Text("Total Amount: \(payManager.totalAmount)")
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
               .blur(radius: payManager.showLogin || payManager.showPurchase || payManager.showConfirm || payManager.showStatus || payManager.isLoading ? 30 : 0)
               
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
```
