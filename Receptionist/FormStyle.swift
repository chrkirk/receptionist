import UIKit

// Styling constants for sign in and sign up forms
class FormStyle: NSObject {
    static let buttonCornerRadius: CGFloat = 4
    static let buttonHeight:       CGFloat = 40
    
    static let horizontalMargin: CGFloat = 24
    static let regularMargin:    CGFloat = 16
    
    static let activeButtonColor   = UIColor.red
    static let inactiveButtonColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.8)
    
    static let buttonTextAttributes: [NSAttributedString.Key:Any] = [
        .font: UIFont.systemFont(ofSize: 14, weight: .bold),
        .foregroundColor: UIColor.white
    ]
}
