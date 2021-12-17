//
//  SignInViewController.swift
//  BFY
//
//  Created by Влада Приходченко on 14.11.2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var loginTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        //        textField.textContentType = .username
        textField.textContentType = .emailAddress
        textField.placeholder = "Электронная почта"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textContentType = .password
        textField.placeholder = "Пароль"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    let viewEmptyRectangle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        view.layer.borderColor = UIColor(rgb: 0x6A7F60).cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    let line1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0x6A7F60)
        return view
    }()
    
    let line2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0x6A7F60)
        return view
    }()
    
    let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 50)
        label.textColor = UIColor(rgb: 0x6A7F60)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let continueSignInButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.textAlignment = .center
        //        button.titleEdgeInsets
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 32)
        button.setTitleColor(UIColor(rgb: 0xfffcf4), for: .normal)
        button.backgroundColor = UIColor(rgb: 0x919F8B)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let forgetButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapForgotPswdButton), for: .touchUpInside)
        button.setTitle("Забыли пароль?", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor(rgb: 0x6A7F60).cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //    let rememberButton: UIButton = {
    //        let button = UIButton()
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        button.setImage(UIImage(named: "box_empty"), for: .normal)
    //        button.addTarget(self, action: #selector(didTapRememberButton), for: .touchUpInside)
    //        return button
    //    }()
    //
    //    let rememberTextButton: UIButton = {
    //        let button = UIButton()
    //        button.translatesAutoresizingMaskIntoConstraints = false
    //        button.setTitle("Запомнить меня", for: .normal)
    //        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
    //        button.setTitleColor(.black, for: .normal)
    //        button.addTarget(self, action: #selector(didTapRememberButton), for: .touchUpInside)
    //        return button
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        
        [viewEmptyRectangle, loginTextField, passwordTextField,
         line1, line2, signInLabel, continueSignInButton,
         forgetButton].forEach {view.addSubview($0)}
        
        setupBackground()
        setupConstraints()
        setupShadows()
        setupKeyboard()
        setupBackButton()
        
        initializeHideKeyboard()
        
        //        rememberButton.isSelected = false
    }
    
    private func setupBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor(rgb: 0x6A7F60)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func setupShadows() {
        applyShadowOnButtons(button: continueSignInButton)
    }
    
    private func setupConstraints() {
        createRectViewConstraint()
        createLoginTextFieldConstraint()
        createPasswordTextFieldConstraint()
        createLine1Constraint()
        createLine2Constraint()
        createSignInLabelConstraint()
        createContinueSignInButtonConstraint()
        createForgetButtonConstraint()
        //        createRememberButtonConstraint()
        //        createRememberTextButtonConstraint()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
    }
    
    private func setupTextFields() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func createRectViewConstraint() {
        viewEmptyRectangle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40).isActive = true
        viewEmptyRectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewEmptyRectangle.heightAnchor.constraint(equalToConstant: 380).isActive = true
        viewEmptyRectangle.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func createLoginTextFieldConstraint() {
        loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTextField.centerYAnchor.constraint(equalTo: viewEmptyRectangle.topAnchor, constant: 60).isActive = true
        loginTextField.widthAnchor.constraint(equalToConstant: 255).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    func createPasswordTextFieldConstraint() {
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 50).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: loginTextField.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    func createLine1Constraint() {
        line1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        line1.centerYAnchor.constraint(equalTo: loginTextField.bottomAnchor).isActive = true
        line1.widthAnchor.constraint(equalTo: loginTextField.widthAnchor).isActive = true
        line1.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func createLine2Constraint() {
        line2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        line2.centerYAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        line2.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor).isActive = true
        line2.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func createSignInLabelConstraint() {
        signInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 160).isActive = true
        signInLabel.widthAnchor.constraint(equalTo: viewEmptyRectangle.widthAnchor).isActive = true
        signInLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signInLabel.layer.shadowColor = UIColor.black.cgColor
        signInLabel.layer.shadowOffset = CGSize(width: 0, height: 3)
        signInLabel.layer.shadowOpacity = 0.3
        signInLabel.layer.shadowRadius = 3
        signInLabel.layer.masksToBounds = false
    }
    
    func createContinueSignInButtonConstraint() {
        continueSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        continueSignInButton.bottomAnchor.constraint(equalTo: viewEmptyRectangle.bottomAnchor, constant: -20).isActive = true
        continueSignInButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        continueSignInButton.widthAnchor.constraint(equalToConstant: 240).isActive = true
        
    }
    
    func createForgetButtonConstraint() {
        forgetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        forgetButton.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 50).isActive = true
        forgetButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        forgetButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    //    func createRememberButtonConstraint() {
    //        rememberButton.centerXAnchor.constraint(equalTo: viewEmptyRectangle.leftAnchor, constant: 70).isActive = true
    //        rememberButton.centerYAnchor.constraint(equalTo: forgetButton.bottomAnchor, constant: 38).isActive = true
    //        rememberButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    //        rememberButton.widthAnchor.constraint(equalTo: rememberButton.heightAnchor).isActive = true
    //    }
    //
    //    func createRememberTextButtonConstraint() {
    //        rememberTextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    //        rememberTextButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
    //        rememberTextButton.leftAnchor.constraint(equalTo: rememberButton.centerXAnchor).isActive = true
    //        rememberTextButton.centerYAnchor.constraint(equalTo: rememberButton.centerYAnchor).isActive = true
    //    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func applyShadowOnButtons(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.6
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
    }
    
    //    @objc private func didTapRememberButton(_ sender: UIButton) {
    //        if rememberButton.isSelected {
    //            rememberButton.setBackgroundImage(UIImage(named: "box_empty"), for: .normal)
    //            rememberButton.isSelected = false
    //        } else {
    //            rememberButton.setBackgroundImage(UIImage(named: "box_filled"), for:.normal)
    //            rememberButton.isSelected = true
    //        }
    //    }
    
    private func showMessageAlert(err: String) {
        let alert = UIAlertController(title: "Ошибка", message: err, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func didTapForgotPswdButton(_ sender: UIButton) {
        guard let email = loginTextField.text
        else { return }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if (email.isEmpty) {
            showMessageAlert(err: "Введите электронную почту")
        } else if !emailPred.evaluate(with: email) {
            showMessageAlert(err: "Введите корректную электронную почту")
        } else {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error != nil {
                    guard let err = error else { return }
                    guard let errCode = AuthErrorCode(rawValue: err._code) else { return }
                    switch errCode {
                    case .invalidEmail:
                        self.showMessageAlert(err: "Введите корректную электронную почту")
                    case .networkError:
                        self.showMessageAlert(err: "Ошибка Интернет-соединения")
                    case .userNotFound:
                        self.showMessageAlert(err: "Пользователь не найден")
                    default:
                        self.showMessageAlert(err: "Неизвестная ошибка")
                    }
                }
            }
        }
    }
    
    @objc private func didTapContinueButton(_ sender: UIButton) {
        guard let pswd = passwordTextField.text,
              let login = loginTextField.text
        else { return }
        
        if (!pswd.isEmpty && !login.isEmpty) {
            if (pswd.count < 6) {
                showMessageAlert(err: "Пароль должен содержать не менее 6 символов")
            } else {
                Auth.auth().signIn(withEmail: login, password: pswd) { (result, error) in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                            let tabBarVC = TabBarController()
                            self.navigationController?.pushViewController(tabBarVC, animated: true)
                        }
                    } else {
                        guard let err = error else { return }
                        guard let errCode = AuthErrorCode(rawValue: err._code) else { return }
                        switch errCode {
                        case .invalidEmail:
                            self.showMessageAlert(err: "Введите корректную электронную почту")
                        case .networkError:
                            self.showMessageAlert(err: "Ошибка Интернет-соединения")
                        case .wrongPassword:
                            self.showMessageAlert(err: "Неверный пароль")
                        case .userNotFound:
                            self.showMessageAlert(err: "Пользователь не найден")
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
    
    @objc private func handleTextInputChange() {
        let isFormValid = loginTextField.text?.count ?? 0 > 0 &&
        passwordTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            continueSignInButton.backgroundColor = UIColor(rgb: 0x6A7F60)
        } else {
            continueSignInButton.backgroundColor = UIColor(rgb: 0x919F8B)
        }
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
}
