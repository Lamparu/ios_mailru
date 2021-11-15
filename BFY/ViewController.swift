import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}


class ViewController: UIViewController {

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
        let imageName = "bookImage.jpeg" //подгуржать с бэкэнда
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
        let imageName = "playButton.png"
        let image = UIImage(named: imageName)
        playButton.setImage(UIImage(named: imageName), for: .normal)
        playButton.layer.cornerRadius=50
        playButton.layer.masksToBounds = true
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    } ()
    
    let stringBookName: UILabel = {
        let text = "Капитанская дочка"
        let str = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        str.text = text
        str.textColor = UIColor.black
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        str.textAlignment = .center
        str.translatesAutoresizingMaskIntoConstraints = false
        return str
    }()
    
    let stringBookAuthor: UILabel = {
        let text = "А. С. Пушкин"
        let str = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        str.text = text
        str.textColor = UIColor.darkGray
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
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
        let text = "Останавились на"
        let str = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        str.text = text
        str.textColor = UIColor(rgb: 0x6A7F60)
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
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
    }
    
    func createMainBookConstraint(){
        mainFrame.widthAnchor.constraint(equalToConstant: 343).isActive = true
        mainFrame.heightAnchor.constraint(equalToConstant: 463).isActive = true
        mainFrame.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        mainFrame.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func createbookImageConstraint(){
        bookImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bookImage.heightAnchor.constraint(equalToConstant: 263).isActive = true
        bookImage.centerYAnchor.constraint(equalTo: mainFrame.centerYAnchor, constant: -70).isActive = true
        bookImage.centerXAnchor.constraint(equalTo: mainFrame.centerXAnchor).isActive = true
        
    }
    func createstringBookNameConstraint() {
        stringBookName.centerXAnchor.constraint(equalTo: bookImage.centerXAnchor).isActive = true
        stringBookName.centerYAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 20).isActive = true
        
    }
    
    func createstringBookAuthorConstraint() {
        stringBookAuthor.centerXAnchor.constraint(equalTo: stringBookName.centerXAnchor).isActive = true
        stringBookAuthor.centerYAnchor.constraint(equalTo: stringBookName.bottomAnchor, constant: 10).isActive = true
        
    }
    
    func createNumberOfListsFieldConstraint() {
        numberOfListsField.centerXAnchor.constraint(equalTo: stringBookAuthor.centerXAnchor).isActive = true
        numberOfListsField.centerYAnchor.constraint(equalTo: stringBookAuthor.bottomAnchor, constant: 50).isActive = true
        
    }
    
    func createstringToListsFieldConstraint() {
        stringToListsField.centerXAnchor.constraint(equalTo: numberOfListsField.centerXAnchor).isActive = true
        stringToListsField.centerYAnchor.constraint(equalTo: numberOfListsField.topAnchor, constant: -10).isActive = true
        
    }

    
    @objc private func didTapRegButton(_ sender: UIButton)
        {
            let Timer = TimerViewContoller()
           let navController = UINavigationController(rootViewController: Timer)
            self.present(navController, animated: true, completion: nil)
            self.navigationController?.pushViewController(Timer, animated: true)
            
            
        }
    
    func applyShadowOnButtons(button: UIButton)
        {
            button.layer.shadowColor = UIColor.black.cgColor
            button.centerXAnchor.constraint(equalTo: mainFrame.centerXAnchor).isActive = true
            button.centerYAnchor.constraint(equalTo: mainFrame.bottomAnchor, constant: 70).isActive = true
            button.heightAnchor.constraint(equalToConstant: 105).isActive = true
            button.widthAnchor.constraint(equalToConstant: 105).isActive = true
        }


}

