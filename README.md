
---

# EVzonePaySDK

A SwiftUI-based iOS SDK for integrating a simple payment flow into your app. This SDK handles user authentication, purchase confirmation, and payment status display through elegant popups, requiring minimal setup from the consumer app.

## Features

- **Customizable**: Pass your own `businessName`, `userId`, `username` (buyer details), `totalAmount`, `itemsPurchased`, and `currency`.
- **Elegant Popups**: Includes a loading view, login popup, purchase confirmation, payment confirmation, and payment status popups with smooth transitions.
- **Minimal Setup**: The app only needs to provide payment details and a button to initiate the payment flow; the SDK handles the rest, including background blur effects during the payment flow.

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

   Create an instance of `EVzonePayManager` with your payment details, add a button to initiate the payment flow, and embed `EVzonePayView` to display the payment UI. The SDK will handle the payment flow and apply a blur effect to the background when the payment flow is active.

   ```swift
   import SwiftUI
   import EVzonePaySDK

   struct ContentView: View {
       @StateObject private var payManager: EVzonePayManager
       
       init() {
           _payManager = StateObject(wrappedValue: EVzonePayManager(
               username: "user1",
               userId: "W-256765384261",
               businessName: "ShopMart",
               totalAmount: "1000",
               itemsPurchased: "Premium Subscription",
               currency: "UGX"
           ))
       }
       
       var body: some View {
           ZStack {
               VStack {
                   VStack(alignment: .leading, spacing: 10) {
                       Text("Item: \(payManager.itemsPurchased)")
                           .font(.headline)
                       Text("Total Amount: \(payManager.currency) \(payManager.totalAmount)")
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

### Notes

- **Button Customization**: The app provides the button and can customize its text (e.g., "Pay Now" can be changed to "Proceed to Payment") and styling.
- **Payment Flow**: When the button is tapped, call `payManager.startPayment()` to initiate the payment flow. The SDK will display a loading view, followed by popups for login (if needed), purchase confirmation, payment confirmation, and payment status.
- **Blur Effect**: The SDK automatically applies a blur effect to the background when the payment flow is active (during loading or when a popup is shown).
- **Required Details**: Ensure you provide all required details to `EVzonePayManager`:
  - `username`: The buyer’s username (optional, used for authentication).
  - `userId`: The buyer’s user ID (required).
  - `businessName`: The name of the business (required).
  - `totalAmount`: The total amount to be paid (required, as a string).
  - `itemsPurchased`: The items being purchased (required).
  - `currency`: The currency for the transaction (optional, defaults to "UGX").

## License

MIT License. See [LICENSE](LICENSE) for details.

---


