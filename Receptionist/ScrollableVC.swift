import UIKit

class ScrollableVC: UIViewController, KeyboardApperanceDelegate {

    let scrollView = UIScrollView(frame: .zero)
    
    // used to calculate the scrollView's contentInsets when the keyboard appears
    var lastSubviewInScrollView : UIView? = nil
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        registerForKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(_:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
        // make view scrollable in case the keyboard hides any of the subviews
        if lastSubviewInScrollView == nil {
            print("You need to set lastSubviewInScrollView to make the view controller scrollable when the keyboard appears")
        }
        
        // calculate keyboard's frame top y position
        let keyboardHighestY: CGFloat = {
            let info : [AnyHashable:Any]! = notification.userInfo
            let kbRect = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect
            return view.frame.size.height - kbRect.size.height
        }()
        
        var offset : CGFloat = 0
        if let subviewLowestY = lastSubviewInScrollView?.calculateLowestPoint().y {
            // if keyboard is on top of (hidding) subviews
            if keyboardHighestY < subviewLowestY {
                offset = subviewLowestY - keyboardHighestY + 30
            }
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: offset, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        scrollView.flashScrollIndicators()
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
    }
    
    private func setupViews() {
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.backgroundColor = .clear
        
        scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollView.contentLayoutGuide.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        scrollView.contentLayoutGuide.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func calculateLowestPoint() -> CGPoint {
        return CGPoint(x: frame.origin.x, y: frame.origin.y + frame.size.height)
    }
}

@objc protocol KeyboardApperanceDelegate {
    var lastSubviewInScrollView : UIView? { get set }
    
    func registerForKeyboardNotifications()
    @objc func keyboardWasShown(_ notification: NSNotification)
    @objc func keyboardWillBeHidden(_ notification: NSNotification)
}
