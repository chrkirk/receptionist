import UIKit

class SignInVC: ScrollableVC {
    
    let brandLabel = BrandLabel()
    
    let username = InputTextField(placeholder: "Email")
    
    let password: InputTextField = {
        let tf = InputTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var signInBtn: UIButton = {
        let btn = UIButton()
        let title = NSAttributedString(string: "SIGN IN", attributes: FormStyle.buttonTextAttributes)
        btn.setAttributedTitle(title, for: .normal)
        btn.layer.cornerRadius = 4
        btn.deactivate()
        btn.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        let title = NSAttributedString(string: "BACK", attributes: FormStyle.buttonTextAttributes)
        btn.setAttributedTitle(title, for: .normal)
        btn.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        lastSubviewInScrollView = signInBtn
        setupViews()
        registerForNotifications()
        username.becomeFirstResponder() // open the keyboard when the view loads
    }
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setButtonState),
                                               name: UITextField.textDidChangeNotification,
                                               object: nil)
    }
    
    @objc func backButtonPressed() {
        username.resignFirstResponder()
        password.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func setButtonState() {
        // increase the opacity of the sign in button if both username and password are filled
        guard (username.text != nil) && (password.text != nil) else {
            signInBtn.deactivate()
            return
        }
        let canSignIn = !username.text!.isEmpty && !password.text!.isEmpty
        if canSignIn {
            signInBtn.activate()
        } else {
            signInBtn.deactivate()
        }
    }
    
    @objc private func signInButtonPressed() {
        print("Sign in")
    }
    
    private func setupViews() {
        scrollView.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: FormStyle.regularMargin).isActive = true
        backBtn.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: FormStyle.regularMargin).isActive = true
        
        let topPadding = view.frame.height * 0.1
        scrollView.addSubview(brandLabel)
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: topPadding).isActive = true
        brandLabel.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: FormStyle.horizontalMargin).isActive = true
        brandLabel.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -FormStyle.horizontalMargin).isActive = true

        scrollView.addSubview(username)
        username.translatesAutoresizingMaskIntoConstraints = false
        username.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: FormStyle.regularMargin).isActive = true
        username.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: FormStyle.horizontalMargin).isActive = true
        username.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -FormStyle.horizontalMargin).isActive = true
        username.heightAnchor.constraint(equalToConstant: FormStyle.buttonHeight).isActive = true

        scrollView.addSubview(password)
        password.translatesAutoresizingMaskIntoConstraints = false
        password.topAnchor.constraint(equalTo: username.bottomAnchor, constant: FormStyle.regularMargin).isActive = true
        password.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: FormStyle.horizontalMargin).isActive = true
        password.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -FormStyle.horizontalMargin).isActive = true
        password.heightAnchor.constraint(equalToConstant: FormStyle.buttonHeight).isActive = true

        scrollView.addSubview(signInBtn)
        signInBtn.translatesAutoresizingMaskIntoConstraints = false
        signInBtn.topAnchor.constraint(equalTo: password.bottomAnchor, constant: FormStyle.horizontalMargin).isActive = true
        signInBtn.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: FormStyle.horizontalMargin).isActive = true
        signInBtn.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: -FormStyle.horizontalMargin).isActive = true
        signInBtn.heightAnchor.constraint(equalToConstant: FormStyle.buttonHeight).isActive = true
    }
}

extension UIButton {
    func activate() {
        backgroundColor = FormStyle.activeButtonColor
        isEnabled = true
    }
    
    func deactivate() {
        backgroundColor = FormStyle.inactiveButtonColor
        isEnabled = false
    }
}
