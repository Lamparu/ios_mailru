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
        let imageName = "bookImage" //подгуржать с бэкэнда
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius=28
        imageView.layer.masksToBounds = true
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
        let str = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        str.text = text
        str.textColor = UIColor.black
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 26)
        str.textAlignment = .center
        str.translatesAutoresizingMaskIntoConstraints = false
        return str
    }()
    
    let stringBookAuthor: UILabel = {
        let text = "Джейн Остен"
        let str = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
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
        view.addSubview(numberOfListsField)
        view.addSubview(stringToListsField)
        
        
        createMainBookConstraint()
        createbookImageConstraint()
        createstringBookNameConstraint()
        createstringBookAuthorConstraint()
        createNumberOfListsFieldConstraint()
        createstringToListsFieldConstraint()
        
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
        bookImage.widthAnchor.constraint(equalToConstant: bookImage.frame.width / 2).isActive = true
        bookImage.heightAnchor.constraint(equalToConstant: bookImage.frame.height / 2).isActive = true
        bookImage.topAnchor.constraint(equalTo: mainFrame.topAnchor, constant: 30).isActive = true
        bookImage.centerXAnchor.constraint(equalTo: mainFrame.centerXAnchor).isActive = true
        
    }
    func createstringBookNameConstraint() {
        stringBookName.centerXAnchor.constraint(equalTo: bookImage.centerXAnchor).isActive = true
        stringBookName.centerYAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 30).isActive = true
    }
    
    func createstringBookAuthorConstraint() {
        stringBookAuthor.centerXAnchor.constraint(equalTo: stringBookName.centerXAnchor).isActive = true
        stringBookAuthor.centerYAnchor.constraint(equalTo: stringBookName.bottomAnchor, constant: 20).isActive = true
    }
    
    func createNumberOfListsFieldConstraint() {
        numberOfListsField.centerXAnchor.constraint(equalTo: stringBookAuthor.centerXAnchor).isActive = true
        numberOfListsField.bottomAnchor.constraint(equalTo: mainFrame.bottomAnchor, constant: -30).isActive = true
    }
    
    func createstringToListsFieldConstraint() {
        stringToListsField.centerXAnchor.constraint(equalTo: numberOfListsField.centerXAnchor).isActive = true
        stringToListsField.centerYAnchor.constraint(equalTo: numberOfListsField.topAnchor, constant: -20).isActive = true
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


}
