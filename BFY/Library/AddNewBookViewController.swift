//
//  AddNewBookViewController.swift
//  BFY
//
//  Created by Анастасия Московчук on 19.11.2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import CryptoKit

class AddNewBookViewController: UIViewController, UITextFieldDelegate {
    
    let db = Firestore.firestore()
    
    let mainFrame: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 28
        return view
    }()
    
    let bookTitle: UILabel = {
        let text = "Введите название книги"
        let str = UILabel()
        str.text = text
        str.textColor = UIColor(rgb: 0x6A7F60)
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 23)
        str.textAlignment = .center
        str.translatesAutoresizingMaskIntoConstraints = false
        return str
    }()
    
    let bookAuthors: UILabel = {
        let text = "Введите авторов книги"
        let str = UILabel()
        str.text = text
        str.textColor = UIColor(rgb: 0x6A7F60)
        str.font = UIFont(name: "AppleSDGothicNeo-Light", size: 23)
        str.textAlignment = .center
        str.translatesAutoresizingMaskIntoConstraints = false
        return str
    }()
    
    var titleField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        //textField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        textField.layer.masksToBounds = true
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        
        return textField
    }()
    
    var authorsField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textAlignment = .center
        textField.layer.cornerRadius = 10
        //textField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        textField.layer.masksToBounds = true
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        
        return textField
    }()
    
    let plusButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.textAlignment = .center
        //        button.titleEdgeInsets
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 32)
        button.setTitleColor(UIColor(rgb: 0xfffcf4), for: .normal)
        button.backgroundColor = UIColor(rgb: 0x919F8B)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
//    override func viewWillAppear(_ animated: Bool) {
//        setEmptySearchResult()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextFields()
        
        [mainFrame, bookTitle, bookAuthors, titleField, authorsField, plusButton]
            .forEach {view.addSubview($0)}
        
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        
        setupConstraints()
        applyShadowOnButtons(button: plusButton)
        
        initializeHideKeyboard()
        setupKeyboard()
    }
    
    private func setupTextFields() {
        authorsField.delegate = self
        titleField.delegate = self
    }
    
    private func setupConstraints() {
        setupTitleLabelConstraints()
        setupTitleFieldConstraints()
        setupAuthorsLabelConstraints()
        setupAuthorsFieldConstraints()
        setupPlusButtonConstraints()
        setupFrameConstraints()
    }
    
    private func setupTitleLabelConstraints() {
        bookTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bookTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70).isActive = true
        bookTitle.widthAnchor.constraint(equalToConstant: 250).isActive = true
        bookTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupTitleFieldConstraints() {
        titleField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleField.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 20).isActive = true
        titleField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        titleField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupAuthorsLabelConstraints() {
        bookAuthors.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bookAuthors.centerYAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 40).isActive = true
        bookAuthors.widthAnchor.constraint(equalToConstant: 250).isActive = true
        bookAuthors.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupAuthorsFieldConstraints() {
        authorsField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        authorsField.topAnchor.constraint(equalTo: bookAuthors.bottomAnchor, constant: 20).isActive = true
        authorsField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        authorsField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupPlusButtonConstraints() {
        plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusButton.topAnchor.constraint(equalTo: authorsField.bottomAnchor, constant: 30).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupFrameConstraints() {
        mainFrame.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainFrame.topAnchor.constraint(equalTo: bookTitle.topAnchor, constant: -30).isActive = true
        mainFrame.widthAnchor.constraint(equalToConstant: 300).isActive = true
        mainFrame.heightAnchor.constraint(equalToConstant: 320).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
    
    private func setupKeyboard()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func applyShadowOnButtons(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.6
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
    }
    
    private func showMessageAlert(err: String) {
        let alert = UIAlertController(title: "Ошибка", message: err, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @objc private func didTapPlusButton(_ sender: UIButton) {
        guard let author = authorsField.text,
              let title = titleField.text
        else { return }
        
        if (author.isEmpty || title.isEmpty) {
            showMessageAlert(err: "Заполните поля")
        } else {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            let dataHash = Data((author + title).utf8)
            let hashed = SHA256.hash(data: dataHash)
            let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
            print(hashString)
//            db.collection("Users").document(userID).updateData(["library": [hashString : "0"]])
            db.collection("Users").document(userID).updateData(["library." + hashString : "0"])
            db.collection("Books").document(hashString).setData(["title": title,
                                                                 "authors": author,
                                                                 "image" : ""])
//            setEmptySearchResult()
            
            self.dismiss(animated: true)
        }
        
    }
    
    @objc private func handleTextInputChange() {
        let isFormValid = authorsField.text?.count ?? 0 > 0 &&
        titleField.text?.count ?? 0 > 0
        
        if isFormValid {
            plusButton.backgroundColor = UIColor(rgb: 0x6A7F60)
        } else {
            plusButton.backgroundColor = UIColor(rgb: 0x919F8B)
        }
    }
}
