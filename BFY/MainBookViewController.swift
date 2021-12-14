import UIKit



class MainBookViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    let mainFrame: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius=28
        return view
    }()
    
    let bookImage: UIImageView = {
        let imageName = "BookCover" //подгуржать с бэкэнда
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let playButton: UIButton = {
        let playButton = UIButton()
        playButton.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
        let imageName = "playButton"
        let image = UIImage(named: imageName)
        playButton.setImage(UIImage(named: imageName), for: .normal)
        playButton.layer.cornerRadius=30
        playButton.layer.masksToBounds = true
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    } ()
    
    let stringBookName: UILabel = {
        let text = "Гордость и предубеждение"
        let str = UILabel()
        str.text = text
        str.textColor = UIColor.black
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 26)
        str.textAlignment = .center
        str.translatesAutoresizingMaskIntoConstraints = false
        return str
    }()
    
    let stringBookAuthor: UILabel = {
        let text = "Джейн Остен"
        let str = UILabel()
        str.text = text
        str.textColor = UIColor.darkGray
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 26)
        str.textAlignment = .center
        str.translatesAutoresizingMaskIntoConstraints = false
        return str
    }()
    
    var numberOfListsField: UITextField = {
    let textField = UITextField()
    let list = 10
    textField.placeholder = "\(list) стр.";// str (число из бэка данные по этой книге)
    textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 25)
    textField.borderStyle = UITextField.BorderStyle.roundedRect
    textField.textAlignment = .center
    textField.layer.cornerRadius = 20
    textField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
    textField.layer.borderColor = UIColor(rgb: 0x6A7F60).cgColor
    textField.layer.borderWidth = 1
    textField.layer.masksToBounds = true
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.resignFirstResponder()

    return textField
    }()
    
    
    let stringToListsField: UILabel = {
        let text = "Остановились на"
        let str = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        str.text = text
        str.textColor = UIColor.black
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        str.textAlignment = .center
        str.translatesAutoresizingMaskIntoConstraints = false
        return str
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        view.addSubview(mainFrame)
        view.addSubview(bookImage)
        view.addSubview(stringBookName)
        view.addSubview(stringBookAuthor)
        view.addSubview(stringToListsField)
        view.addSubview(numberOfListsField)
        
        setupKeyboard()
        
        
        createMainBookConstraint()
        createbookImageConstraint()
        createstringBookNameConstraint()
        createstringBookAuthorConstraint()
        createstringToListsFieldConstraint()
        createNumberOfListsFieldConstraint()
        
        self.view.addSubview(playButton)
        applyShadowOnButtons(button: playButton)

        // Do any additional setup after loading the view.
        
//        let backButton = UIBarButtonItem()
//        backButton.title = ""
//        backButton.tintColor = UIColor(rgb: 0x6A7F60)
//        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationItem.hidesBackButton = true
    }
    
    func createMainBookConstraint(){
        mainFrame.widthAnchor.constraint(equalToConstant: 343).isActive = true
        mainFrame.heightAnchor.constraint(equalToConstant: 463).isActive = true
        mainFrame.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        mainFrame.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func createbookImageConstraint(){
        bookImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bookImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        bookImage.topAnchor.constraint(equalTo: mainFrame.topAnchor, constant: 30).isActive = true
        bookImage.centerXAnchor.constraint(equalTo: mainFrame.centerXAnchor).isActive = true
        
    }
    func createstringBookNameConstraint() {
        stringBookName.widthAnchor.constraint(equalToConstant: 320).isActive = true
        stringBookName.centerXAnchor.constraint(equalTo: bookImage.centerXAnchor).isActive = true
        stringBookName.centerYAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 30).isActive = true
    }
    
    func createstringBookAuthorConstraint() {
        stringBookAuthor.widthAnchor.constraint(equalToConstant: 320).isActive = true
        stringBookAuthor.centerXAnchor.constraint(equalTo: stringBookName.centerXAnchor).isActive = true
        stringBookAuthor.centerYAnchor.constraint(equalTo: stringBookName.bottomAnchor, constant: 20).isActive = true
    }
    
    func createstringToListsFieldConstraint() {
        stringToListsField.centerXAnchor.constraint(equalTo: stringBookAuthor.centerXAnchor).isActive = true
        stringToListsField.centerYAnchor.constraint(equalTo: stringBookAuthor.bottomAnchor, constant: 20).isActive = true
    }
    
    func createNumberOfListsFieldConstraint() {
        numberOfListsField.centerXAnchor.constraint(equalTo: stringToListsField.centerXAnchor).isActive = true
        numberOfListsField.topAnchor.constraint(equalTo: stringToListsField.bottomAnchor, constant: 10).isActive = true
    }
    
    

    
    @objc private func didTapRegButton(_ sender: UIButton) {
        let Timer = TimerViewContoller()
   //           let navController = UINavigationController(rootViewController: Timer)
   //            self.present(navController, animated: true, completion: nil)
        self.navigationController?.pushViewController(Timer, animated: true)
    }
    
    func applyShadowOnButtons(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.centerXAnchor.constraint(equalTo: mainFrame.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: mainFrame.bottomAnchor, constant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 75).isActive = true
        button.widthAnchor.constraint(equalToConstant: 75).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc private func didTapProfileButton(_ sender: UIButton) {
        let profileVC = ProfileViewController()
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func setupKeyboard()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 180
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }


}
