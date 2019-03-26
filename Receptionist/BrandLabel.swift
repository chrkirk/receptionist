import UIKit

class BrandLabel: UILabel {
    
    static let defaultFontSize: CGFloat = 32
    static let defaultText = "The Receptionist"
    
    let paragraphStyleCenter: NSMutableParagraphStyle = {
        let ps = NSMutableParagraphStyle()
        ps.alignment = .center
        return ps
    }()
    
    lazy var textAttributes: [NSAttributedString.Key:Any] = [
        .font: UIFont.italicSystemFont(ofSize: BrandLabel.defaultFontSize),
        .underlineStyle: NSNumber(value: NSUnderlineStyle.double.rawValue),
        .underlineColor: UIColor.red,
        .foregroundColor: UIColor.white,
        .paragraphStyle: self.paragraphStyleCenter
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attributedText  = NSAttributedString(string: BrandLabel.defaultText, attributes: textAttributes)
        backgroundColor = .clear
    }
    
    init(withFontSize fontSize: CGFloat) {
        super.init(frame: .zero)
        textAttributes[.font] = UIFont.italicSystemFont(ofSize: fontSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }   
}
