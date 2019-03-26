import UIKit

class PageCell: UICollectionViewCell {
    
    lazy var textViewHeight  = self.contentView.frame.height * 0.3
    lazy var textViewPadding = contentView.frame.width * 0.06
    
    lazy var imageHeight: CGFloat = {
        let height = contentView.frame.height - self.textViewHeight
        let width  = contentView.frame.width
        return CGFloat.minimum(height, width) * 0.9
    }()
    
    let paragraphStyleCenter: NSMutableParagraphStyle = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return paragraphStyle
    }()
    
    lazy var titleTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 20, weight: .medium),
        .foregroundColor: UIColor.white,
        .paragraphStyle: self.paragraphStyleCenter
    ]
    
    lazy var messageTextAttributes: [NSAttributedString.Key : Any] = [
        .font: UIFont.systemFont(ofSize: 16, weight: .regular),
        .foregroundColor: UIColor.white,
        .paragraphStyle: self.paragraphStyleCenter
    ]
    
    let imageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.image = UIImage(named: "default")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.lightGray.cgColor
        iv.layer.borderWidth = 2
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView(frame: .zero)
        tv.isEditable = false
        tv.backgroundColor = .clear
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        setupViews()
    }
    
    func setContent(withPage page: Page) {
        if let image = UIImage(named: page.imageName) {
            imageView.image = image
        }
        
        let text = NSMutableAttributedString(string: page.title, attributes: titleTextAttributes)
        text.append(NSAttributedString(string: "\n\n\(page.message)", attributes: messageTextAttributes))
        textView.attributedText = text
    }
    
    private func setupViews() {
        contentView.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: textViewPadding).isActive = true
        textView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -textViewPadding).isActive = true
        textView.heightAnchor.constraint(equalToConstant: textViewHeight).isActive = true
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -16).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        imageView.layer.cornerRadius = imageHeight / 2
}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
