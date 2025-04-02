
# EVzonePaySDK

A SwiftUI-based iOS SDK for integrating a simple payment flow into your app. This SDK handles user authentication, purchase confirmation, and payment status display through elegant popups, requiring minimal setup from the consumer app.

## Features
- **User Validation**: Checks if a username exists before proceeding.
- **Passcode Verification**: Ensures the entered passcode matches the stored one.
- **Balance Check**: Confirms sufficient funds for the transaction.
- **Popup UI**: Provides a complete payment flow with Login, Purchase, Confirmation, and Status popups.
- **Customizable**: Pass your own username, total amount, items purchased, and image.

## Requirements
- iOS 13.0 or later
- Swift 5.5+
- Xcode 13.0+

## Installation

### Swift Package Manager

1. In Xcode, go to `File > Add Packages`.
2. Enter the repository URL: `https://github.com/Bravothe/EVzonePaySDK.git` (replace with your actual repo URL).
3. Select the version or branch you want (e.g., `main`).
4. Add the package to your target.

## Usage

### Quick Start

1. **Import the SDK**:
   ```swift
   import EVzonePaySDK
   ```

2. **Set Up in Your View**:

   Create an instance of `EVzonePayManager` with your payment details and add `EVzonePayView` to your view hierarchy.

   ```swift
   import SwiftUI
   import EVzonePaySDK

   struct ContentView: View {
       @StateObject private var payManager = EVzonePayManager(
           username: "user1", // Optional: nil if no user
           totalAmount: "$100.49",
           itemsPurchased: "Premium Subscription"
       )
       private let paymentImageName = "yourImageName" // Provided by your app

       var body: some View {
           ZStack {
               VStack {
                   Image(paymentImageName)
                       .resizable()
                       .frame(width: 300, height: 300)
                   Text("Item: \(payManager.itemsPurchased)")
                       .font(.headline)
                   Text("Total: \(payManager.totalAmount)")
                       .font(.headline)
                   Button("Pay Now") {
                       payManager.startPayment()
                   }
                   .frame(width: 200, height: 50)
                   .background(Color.blue)
                   .foregroundColor(.white)
                   .cornerRadius(10)
                   Spacer()
               }
               .blur(radius: payManager.showLogin || payManager.showPurchase || payManager.showConfirm || payManager.showStatus ? 30 : 0)
               
               EVzonePayView(manager: payManager, imageName: paymentImageName)
           }
       }
   }
   ```

### How It Works

1. **Initialize**: Create an `EVzonePayManager` with a `username` (optional), `totalAmount`, and `itemsPurchased`.
2. **Trigger Payment**: Call `startPayment()` on the manager when the user taps "Pay Now".
3. **Popups**: The SDK automatically displays the appropriate popup (Login, Purchase, Confirm, or Status) based on the flow:
   - If no valid username, shows a Login popup.
   - If username exists, proceeds to Purchase, then Confirm (passcode entry).
   - Validates passcode and balance, showing the final Status.

### Example Users

For testing, the SDK includes a mock user database:
- Username: `user1`, Passcode: `1234`, Balance: `$150.00`
- Username: `user2`, Passcode: `5678`, Balance: `$50.00`

Try with `user1` (succeeds for $100.49) or `user2` (fails due to insufficient funds).

## Customization

- **Image**: Pass an `imageName` from your app’s asset catalog to brand the popups.
- **Styling**: The popups use system colors and fonts, adapting to light/dark mode automatically.

## Notes

- **Assets**: The SDK doesn’t include an assets folder; provide the image name from your app.
- **Real-World Use**: Replace the mock user database with your own backend or storage solution.

## License

MIT License. See [LICENSE](LICENSE) for details.

---

### Notes on the README
- **Simple**: Focuses on quick setup and usage with a clear example.
- **Easy**: Uses minimal technical jargon, making it accessible to beginners.
- **Relevant**: Highlights the SDK’s key features (validation, popups) and how to integrate it.
- **Testable**: Includes example users so developers can try it immediately.

