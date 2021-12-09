//
//  RegistrationViewController.swift
//  BFY
//
//  Created by Влада Приходченко on 28.10.2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    let regLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 40)
        label.textColor = UIColor(rgb: 0x6A7F60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Логин"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        label.textColor = UIColor(rgb: 0x6A7F60)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Электронная почта"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        label.textColor = UIColor(rgb: 0x6A7F60)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        label.textColor = UIColor(rgb: 0x6A7F60)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordAgainLabel: UILabel = {
        let label = UILabel()
        label.text = "Повторите пароль"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        label.textColor = UIColor(rgb: 0x6A7F60)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var loginTextField: UITextField = {
        let textField = UITextField()
//        textField.textContentType = .username
        textField.keyboardType = .emailAddress
        textField.placeholder = "username"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.layer.cornerRadius = 5
        textField.layer.backgroundColor = UIColor(rgb: 0xFFFEFC).cgColor
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textContentType = .newPassword
        textField.placeholder = "*****"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 5
        textField.layer.backgroundColor = UIColor(rgb: 0xFFFEFC).cgColor
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    var passwordAgainTextField: UITextField = {
        let textField = UITextField()
        textField.textContentType = .newPassword
        textField.placeholder = "*****"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 5
        textField.layer.backgroundColor = UIColor(rgb: 0xFFFEFC).cgColor
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.textContentType = .username
//        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.placeholder = "example@domen.ru"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.layer.cornerRadius = 5
        textField.layer.backgroundColor = UIColor(rgb: 0xFFFEFC).cgColor
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    let continueRegButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 32)
        button.setTitleColor(UIColor(rgb: 0xfffcf4), for: .normal)
//        button.backgroundColor = UIColor(rgb: 0x6A7F60)
        button.backgroundColor = UIColor(rgb: 0x919F8B)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupKeyboard()
        
        [regLabel, emailLabel, loginLabel, loginTextField,
         emailTextField, passwordLabel, passwordTextField,
         passwordAgainLabel, passwordAgainTextField,
         continueRegButton].forEach {view.addSubview($0)}
        
        setupBackground()
        setupConstraints()
        setupShadows()
        setupBackButton()
        
//        let ref = Database.database().reference()
//        //ref.child("userid/username").setValue("Colorit")
//        ref.childByAutoId().setValue(["email" : ""])
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor(rgb: 0x6A7F60)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func setupKeyboard()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupShadows() {
        applyShadowOnButtons(button: continueRegButton)
    }
    
    private func setupConstraints() {
        createRegLabelConstraint()
        createLoginLabelConstraint()
        createLoginTextFieldConstraint()
        createEmailLabelConstraint()
        createEmailTextFieldConstraint()
        createPasswordLabelConstraint()
        createPasswordTextFieldConstraint()
        createPasswordAgainLabelConstraint()
        createPasswordAgainTextFieldConstraint()
        createContinueRegButtonConstraint()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
    }
    
    private func setupTextFields() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self
        emailTextField.delegate = self
    }
    
    func createRegLabelConstraint() {
        regLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        regLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 165).isActive = true
        regLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        regLabel.widthAnchor.constraint(equalToConstant: 255).isActive = true
        regLabel.layer.shadowColor = UIColor.black.cgColor
        regLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        regLabel.layer.shadowOpacity = 0.3
        regLabel.layer.shadowRadius = 3
        regLabel.layer.masksToBounds = false
    }
    
    func createLoginLabelConstraint() {
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginLabel.centerYAnchor.constraint(equalTo: regLabel.bottomAnchor, constant: 70).isActive = true
        loginLabel.widthAnchor.constraint(equalToConstant: 245).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }

    func createLoginTextFieldConstraint() {
        loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 2).isActive = true
        loginTextField.widthAnchor.constraint(equalTo: loginLabel.widthAnchor).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func createEmailLabelConstraint() {
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30).isActive = true
//        emailLabel.centerYAnchor.constraint(equalTo: regLabel.bottomAnchor, constant: 100).isActive = true
        emailLabel.widthAnchor.constraint(equalToConstant: 245).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    func createEmailTextFieldConstraint() {
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 2).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 245).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func createPasswordLabelConstraint() {
        passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordLabel.centerYAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true
        passwordLabel.widthAnchor.constraint(equalToConstant: 245).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    func createPasswordTextFieldConstraint() {
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 2).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 245).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func createPasswordAgainLabelConstraint() {
        passwordAgainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordAgainLabel.centerYAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30).isActive = true
        passwordAgainLabel.widthAnchor.constraint(equalToConstant: 245).isActive = true
        passwordAgainLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    func createPasswordAgainTextFieldConstraint() {
        passwordAgainTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordAgainTextField.topAnchor.constraint(equalTo: passwordAgainLabel.bottomAnchor, constant: 2).isActive = true
        passwordAgainTextField.widthAnchor.constraint(equalToConstant: 245).isActive = true
        passwordAgainTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func createContinueRegButtonConstraint() {
        continueRegButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueRegButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 130).isActive = true
        continueRegButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        continueRegButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    func applyShadowOnButtons(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.6
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
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

    private func showMessageAlert(err: String) {
        let alert = UIAlertController(title: "Ошибка", message: err, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func handleTextInputChange() {
        let isFormValid = emailTextField.text?.count ?? 0 > 0 &&
        loginTextField.text?.count ?? 0 > 0 &&
        passwordTextField.text?.count ?? 0 > 0 &&
        passwordAgainTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            continueRegButton.backgroundColor = UIColor(rgb: 0x6A7F60)
        } else {
            continueRegButton.backgroundColor = UIColor(rgb: 0x919F8B)
        }
    }
    
    @objc private func didTapRegButton(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let pswd = passwordTextField.text,
              let login = loginTextField.text,
              let pswd_again = passwordAgainTextField.text
        else { return }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if (!email.isEmpty && !pswd.isEmpty && !login.isEmpty && !pswd_again.isEmpty) {
//        if (!email.isEmpty && !pswd.isEmpty && !pswd_again.isEmpty) {
            if (!emailPred.evaluate(with: email)) {
                showMessageAlert(err: "Введите корректную электронную почту")
            } else if (pswd != pswd_again) {
                showMessageAlert(err: "Пароли не совпадают")
            } else if (pswd.count < 6) {
                showMessageAlert(err: "Пароль должен содержать не менее 6 символов")
            } else {
                Auth.auth().createUser(withEmail: email, password: pswd) { (result, error) in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                            let ref = Database.database().reference()
                            ref.child(result.user.uid).setValue(["username": login, "email": email])
                            let bookVC = MainBookViewController()
                            self.navigationController?.pushViewController(bookVC, animated: true)
                        }
                    } else {
                        print(error!)
                        print(error!.localizedDescription)
                        guard let err = error else { return }
                        guard let errCode = AuthErrorCode(rawValue: err._code) else { return }
                            switch errCode {
                            case .emailAlreadyInUse:
                                self.showMessageAlert(err: "Электронная почта уже используется")
                            case .invalidEmail:
                                self.showMessageAlert(err: "Введите корректную электронную почту")
                            case .networkError:
                                self.showMessageAlert(err: "Ошибка интернет-соединения")
                            default:
                                self.showMessageAlert(err: "Неизвестная ошибка")
                            }
                        }
                    }
                }
        } else {
            showMessageAlert(err: "Заполните все поля")
        }
    }
}
