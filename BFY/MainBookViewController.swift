import UIKit
import Firebase
import FirebaseFirestore
import SwiftUI

var lastBookID = ""

class MainBookViewController: UIViewController, UITextFieldDelegate {
    
    let db = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        updatePages()
        let loader = self.loader()
//        loadBook()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.stopLoader(loader: loader)
        }
    }
    
    let mainFrame: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 28
        return view
    }()
    
    let bookImage: UIImageView = {
        let imageName = "" //подгуржать с бэкэнда
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
        //        let text = "Гордость и предубеждение"
        let str = UILabel()
        //        str.text = text
        str.textColor = UIColor.black
        str.numberOfLines = 2
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 26)
        str.textAlignment = .center
        str.translatesAutoresizingMaskIntoConstraints = false
        return str
    }()
    
    let stringBookAuthor: UILabel = {
        //        let text = "Джейн Остен"
        let str = UILabel()
        //        str.text = text
        str.textColor = UIColor.darkGray
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 26)
        str.textAlignment = .center
        str.translatesAutoresizingMaskIntoConstraints = false
        return str
    }()
    
    var numberOfListsField: UITextField = {
        let textField = UITextField()
        //        let list = 10
        textField.keyboardType = .numberPad
        //        textField.placeholder = "\(list) стр.";// str (число из бэка данные по этой книге)
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
        
        numberOfListsField.delegate = self
        setupKeyboard()
        
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        view.addSubview(mainFrame)
        view.addSubview(bookImage)
        view.addSubview(stringBookName)
        view.addSubview(stringBookAuthor)
        view.addSubview(stringToListsField)
        view.addSubview(numberOfListsField)
        
        
        createMainBookConstraint()
        createbookImageConstraint()
        createstringBookNameConstraint()
        createstringBookAuthorConstraint()
        createstringToListsFieldConstraint()
        createNumberOfListsFieldConstraint()
        
        self.view.addSubview(playButton)
        applyShadowOnButtons(button: playButton)
        
        loadBook{ }
        
        navigationItem.hidesBackButton = true
        
        initializeHideKeyboard()
        setupToolbar()
        
    }
    
    
    private func checkBookDB() {
        
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
            stringBookName.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 10).isActive = true
        }
        
        func createstringBookAuthorConstraint() {
            stringBookAuthor.widthAnchor.constraint(equalToConstant: 320).isActive = true
            stringBookAuthor.centerXAnchor.constraint(equalTo: stringBookName.centerXAnchor).isActive = true
            stringBookAuthor.topAnchor.constraint(equalTo: stringBookName.bottomAnchor, constant: 10).isActive = true
        }
        
        func createstringToListsFieldConstraint() {
            stringToListsField.centerXAnchor.constraint(equalTo: stringBookAuthor.centerXAnchor).isActive = true
            stringToListsField.topAnchor.constraint(equalTo: stringBookAuthor.bottomAnchor, constant: 10).isActive = true
        }
        
        func createNumberOfListsFieldConstraint() {
            numberOfListsField.centerXAnchor.constraint(equalTo: stringToListsField.centerXAnchor).isActive = true
            numberOfListsField.bottomAnchor.constraint(equalTo: mainFrame.bottomAnchor, constant: -15).isActive = true
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
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= 100
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    private func setupKeyboard()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setDefaultBook() {
        stringBookName.text = "Добавьте книгу из библиотеки"
//        stringBookAuthor.text = "Добавьте книгу из библиотеки"
        bookImage.image = UIImage(named: "BookCover")
        numberOfListsField.isHidden = true
        playButton.isHidden = true
        stringToListsField.isHidden = true
    }
    
//    private func setBookData(title: String, authors: String, image: String, pages: String) {
//        if title == "" {
//            self.stringBookName.text = "Название"
//        } else {
//            self.stringBookName.text = title
//        }
//        if authors == "" {
//            self.stringBookAuthor.text = "Автор"
//        } else {
//            self.stringBookAuthor.text = authors
//        }
//        if image == "BookCover" || image == "" {
//            self.bookImage.image = UIImage(named: image)
//        } else {
//            self.bookImage.load(url: URL(string: image)!)
//        }
//        self.numberOfListsField.placeholder = "\(pages) стр."
//    }
    
    private func loadBook(completion: @escaping () -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userRef = db.collection("Users").document(userID)
//        let bookRefColl = db.collection("Books")
        
        userRef.addSnapshotListener { (snapshot, error) in
            print(error ?? "OK user loadBook")
            guard let snapshot = snapshot else {
                completion()
                return
            }
            let data = snapshot.data()
            let last = data?["lastBook"] as? String ?? ""
            if last == "" {
                self.setDefaultBook()
                completion()
                return
            }
            lastBookID = last.trimmingCharacters(in: .whitespaces)
            let bookRef = self.db.collection("Books").document(last.trimmingCharacters(in: .whitespaces))
            bookRef.addSnapshotListener { (bookDoc, bookErr) in
                print(error ?? "OK user loadBook")
                guard let bookDoc = bookDoc else {
                    completion()
                    return
                }
                let book = bookDoc.data()
                let title = book?["title"] as? String ?? "Название"
                self.stringBookName.text = title //book?["title"] as? String ?? "Название книги"
                let authors = book?["authors"] as? String ?? "Автор"
                self.stringBookAuthor.text = authors //book?["authors"] as? String ?? "Автор книги"
                let image = book?["image"] as? String ?? "BookCover"
                if image == "BookCover" || image == "" {
                    self.bookImage.image = UIImage(named: "BookCover")
                } else {
                    self.bookImage.load(url: URL(string: image)!)
                }
                completion()
            }
            let lib = data?["library"] as? [String : String]
            if lib != nil {
                for (bookid, pages) in lib ?? ["":""] {
                    if bookid == last {
                        print("pages: ", pages)
                        if pages == "" {
                            self.numberOfListsField.placeholder = "0 стр."
                        } else {
                            self.numberOfListsField.placeholder = "\(pages) стр."
                        }
                        completion()
                        return
                    }
                }
            }
            self.numberOfListsField.placeholder = "0 стр."
            completion()
        }
    }
    
    func setupToolbar(){
        //Create a toolbar
        let bar = UIToolbar()
        
        //Create a done button with an action to trigger our function to dismiss the keyboard
        let doneBtn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissMyKeyboard))
        
        //Create a felxible space item so that we can add it around in toolbar to position our done button
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //Add the created button items in the toobar
        bar.items = [flexSpace, flexSpace, doneBtn]
        bar.sizeToFit()
        
        //Add the toolbar to our textfield
        numberOfListsField.inputAccessoryView = bar
    }
    
    private func showMessageAlert(err: String) {
        let alert = UIAlertController(title: "Ошибка", message: err, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc override func dismissMyKeyboard() {
        guard let pages = numberOfListsField.text else { return }
        print("pages:", pages)
        numberOfListsField.text = ""
        if pages != "" {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            db.collection("Users").document(userID).updateData(["library." + lastBookID : pages])
        }
        view.endEditing(true)
    }
    
}
