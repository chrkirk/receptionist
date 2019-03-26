import UIKit

class ReceptionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let buttonTextAttributes: [NSAttributedString.Key:Any] = [
        .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
    ]
    
    let buttonCornerRadius: CGFloat = 2
    let buttonHeight:       CGFloat = 40
    let smallMargin:        CGFloat = 8
    let mediumMargin:       CGFloat = 16
    let bigMargin:          CGFloat = 32
    
    let cellId = "cellId"
    
    let pages: [Page] = [
        Page(title: "Cursus vitae congue mauris",
             message: "Consectetur lorem donec massa sapien faucibus et molestie. Egestas maecenas pharetra.",
             imageName: "coffee"),
        Page(title: "Egestas maecenas pharetra",
             message: "Egestas maecenas pharetra convallis posuere morbi leo. ",
             imageName: "newspapers"),
        Page(title: "Ut enim blandit",
             message: "Nec nam aliquam sem et tortor consequat id porta nibh.",
             imageName: "violist")
    ]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection    = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        cv.isPagingEnabled = true
        cv.delegate        = self
        cv.dataSource      = self
        cv.backgroundColor = .clear
        return cv
    }()
    
    let brandLabel = BrandLabel()
    
    lazy var signInBtn: UIButton = {
        let btn  = UIButton(frame: .zero)
        let title = NSAttributedString(string: "LOG IN", attributes: buttonTextAttributes)
        btn.setAttributedTitle(title, for: .normal)
        btn.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        btn.layer.cornerRadius = buttonCornerRadius
        btn.backgroundColor    = .white
        return btn
    }()
    
    lazy var signUpBtn: UIButton = {
        let btn = UIButton(frame: .zero)
        let title = NSAttributedString(string: "SIGN UP", attributes: buttonTextAttributes)
        btn.setAttributedTitle(title, for: .normal)
        btn.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        btn.layer.cornerRadius = buttonCornerRadius
        btn.backgroundColor    = .white
        return btn
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl(frame: .zero)
        pc.numberOfPages = self.pages.count
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .red
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
    }
    
    @objc private func signInPressed() {
        let signInVC = SignInVC()
        self.present(signInVC, animated: true, completion: nil)
        print("Sign in pressed")
    }
    
    @objc private func registerPressed() {
        let signUpVC = SignUpVC()
        self.present(signUpVC, animated: true, completion: nil)
        print("Register in pressed")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        cell.setContent(withPage: pages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        pageControl.updateCurrentPageDisplay()
    }
    
    private func setupViews() {
        view.addSubview(brandLabel)
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: mediumMargin).isActive = true
        brandLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        brandLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        view.addSubview(signUpBtn)
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -mediumMargin).isActive = true
        signUpBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: smallMargin).isActive = true
        signUpBtn.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -smallMargin).isActive = true
        signUpBtn.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        view.addSubview(signInBtn)
        signInBtn.translatesAutoresizingMaskIntoConstraints = false
        signInBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -mediumMargin).isActive = true
        signInBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -smallMargin).isActive = true
        signInBtn.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: smallMargin).isActive = true
        signInBtn.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: signUpBtn.topAnchor, constant: -8).isActive = true
        pageControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: brandLabel.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
