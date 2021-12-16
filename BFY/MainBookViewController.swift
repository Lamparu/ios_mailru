import UIKit
import Firebase
import FirebaseFirestore
import SwiftUI


class MainBookViewController: UIViewController, UITextFieldDelegate {
    
    let db = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let loader = self.loader()
//        loadBook()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.stopLoader(loader: loader)
        }
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        //        imageView.layer.cornerRadius=28
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
        //        let text = "Гордость и предубеждение"
        let str = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        //        str.text = text
        str.textColor = UIColor.black
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 26)
        str.textAlignment = .center
        str.translatesAutoresizingMaskIntoConstraints = false
        return str
    }()
    
    let stringBookAuthor: UILabel = {
        //        let text = "Джейн Остен"
        let str = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
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
        textField.keyboardType = .decimalPad
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
        
//        let loader = self.loader()
        
        numberOfListsField.delegate = self
        setupKeyboard()
        
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
        
        loadBook()
        
        navigationItem.hidesBackButton = true
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.stopLoader(loader: loader)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let loader = self.loader()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            self.stopLoader(loader: loader)
//        }
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
        
    }
    
//    private func fetchDataBook() {
//        db.collection("Users").addSnapshotListener{ (querySnapshot, error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//
//
//        }
//    }
    
    private func getBookData() -> (title: String, author: String, image: String, pages: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return ("", "", "", "") }
        var pages = "0"
        var title = ""
        var authors = ""
        var image = ""
        let userRef = db.collection("Users").document(userID)
//        let bookRefColl = db.collection("Books")
//        let bookRefColl = db.collection("Books")
        
//        print(type(of: userRef))
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let library = document.data() //as! [String: Int]
                let last = library?["lastBook"] as? String ?? ""
                let bookRef = self.db.collection("Books").document(last.trimmingCharacters(in: .whitespaces))
//                let bookRef = bookRefColl.document(last)
                bookRef.getDocument{ (bookDoc, bookErr) in
                    if let bookDoc = bookDoc, bookDoc.exists {
                        let book = bookDoc.data()
                        title = book?["title"] as? String ?? "Название книги"
//                        self.stringBookName.text = title //book?["title"] as? String ?? "Название книги"
                        authors = book?["authors"] as? String ?? ""
//                        self.stringBookAuthor.text = authors //book?["authors"] as? String ?? "Автор книги"
                        image = book?["image"] as? String ?? "BookCover"
//                        if image == "BookCover" {
//                            self.bookImage.image = UIImage(named: image)
//                        } else {
//                            self.bookImage.load(url: URL(string: image)!)
//                        }
                    } else {
                        print("Books collection does not exist")
                    }
                }
                let lib = library?["library"] as? [String : String]
                for (bookid, lastPage) in lib ?? [:] {
                    if bookid == last {
                        pages = lastPage
//                        self.numberOfListsField.placeholder = "\(pages) стр."
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
        return (title, authors, image, pages)
    }
    
    private func setBookData(title: String, authors: String, image: String, pages: String) {
        self.stringBookName.text = title
        self.stringBookAuthor.text = authors
        if image == "BookCover" || image == "" {
            self.bookImage.image = UIImage(named: image)
        } else {
            self.bookImage.load(url: URL(string: image)!)
        }
        self.numberOfListsField.placeholder = "\(pages) стр."
    }
    
    private func loadBook() {
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let userRef = db.collection("Users").document(userID)
//        let bookRefColl = db.collection("Books")
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let library = document.data() //as! [String: Int]
                let last = library?["lastBook"] as? String ?? ""
                let bookRef = self.db.collection("Books").document(last.trimmingCharacters(in: .whitespaces))
//                let bookRef = bookRefColl.document(last)
                bookRef.getDocument{ (bookDoc, bookErr) in
                    if let bookDoc = bookDoc, bookDoc.exists {
                        let book = bookDoc.data()
                        let title = book?["title"] as? String ?? "Название книги"
                        self.stringBookName.text = title //book?["title"] as? String ?? "Название книги"
                        let authors = book?["authors"] as? String ?? ""
                        self.stringBookAuthor.text = authors //book?["authors"] as? String ?? "Автор книги"
                        let image = book?["image"] as? String ?? "BookCover"
                        if image == "BookCover" {
                            self.bookImage.image = UIImage(named: image)
                        } else {
                            self.bookImage.load(url: URL(string: image)!)
                        }
                    } else {
                        print("Books collection does not exist")
                    }
                }
                let lib = library?["library"] as? [String : String]
                for (bookid, pages) in lib ?? [:] {
                    if bookid == last {
                        self.numberOfListsField.placeholder = "\(pages) стр."
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
}
