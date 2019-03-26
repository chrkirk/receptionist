import UIKit

class InputTextField: UITextField {
    
    static let defaultPlaceholder = "placeholder"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(placeholder: String?) {
        super.init(frame: .zero)
        self.placeholder = placeholder ?? InputTextField.defaultPlaceholder
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        leftViewMode       = .always
        backgroundColor    = .white
        layer.cornerRadius = 4
        layer.borderColor  = UIColor.lightGray.cgColor
        layer.borderWidth  = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
