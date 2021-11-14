//
//  MainBookViewController.swift
//  BFY
//
//  Created by Влада Приходченко on 28.10.2021.
//

import UIKit

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
        textField.placeholder = "username"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.layer.cornerRadius = 5
        textField.layer.backgroundColor = UIColor(rgb: 0xFFFEFC).cgColor
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "*****"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.isSecureTextEntry.toggle()
        textField.layer.cornerRadius = 5
        textField.layer.backgroundColor = UIColor(rgb: 0xFFFEFC).cgColor
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        
        return textField
    }()
    
    var passwordAgainTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "*****"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.isSecureTextEntry.toggle()
        textField.layer.cornerRadius = 5
        textField.layer.backgroundColor = UIColor(rgb: 0xFFFEFC).cgColor
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        
        return textField
    }()
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "example@domen.ru"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 24)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.layer.cornerRadius = 5
        textField.layer.backgroundColor = UIColor(rgb: 0xFFFEFC).cgColor
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        
        return textField
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self
        emailTextField.delegate = self
        
        view.addSubview(regLabel)
        view.addSubview(loginLabel)
        view.addSubview(loginTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordAgainLabel)
        view.addSubview(passwordAgainTextField)
        
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        
        createRegLabelConstraint()
        createLoginLabelConstraint()
        createLoginTextFieldConstraint()
        createEmailLabelConstraint()
        createEmailTextFieldConstraint()
        createPasswordLabelConstraint()
        createPasswordTextFieldConstraint()
        createPasswordAgainLabelConstraint()
        createPasswordAgainTextFieldConstraint()
        
        let continueRegButton = UIButton()
        //continueSignInButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        continueRegButton.setTitle("Продолжить", for: .normal)
        continueRegButton.titleLabel?.textAlignment = .center
        continueRegButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 32)
        continueRegButton.setTitleColor(UIColor(rgb: 0xfffcf4), for: .normal)
        continueRegButton.backgroundColor = UIColor(rgb: 0x6A7F60)
        continueRegButton.layer.cornerRadius = 20
        continueRegButton.translatesAutoresizingMaskIntoConstraints = false
        applyShadowOnButtons(button: continueRegButton)
        
        view.addSubview(continueRegButton)
        
        createContinueRegButtonConstraint(button: continueRegButton)
        
    }
    
    func createRegLabelConstraint()
    {
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
    
    func createLoginLabelConstraint()
    {
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginLabel.centerYAnchor.constraint(equalTo: regLabel.bottomAnchor, constant: 70).isActive = true
        loginLabel.widthAnchor.constraint(equalToConstant: 245).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    func createLoginTextFieldConstraint()
    {
        loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 2).isActive = true
        loginTextField.widthAnchor.constraint(equalTo: loginLabel.widthAnchor).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func createEmailLabelConstraint()
    {
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.centerYAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: loginLabel.widthAnchor).isActive = true
        emailLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    func createEmailTextFieldConstraint()
    {
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 2).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: loginLabel.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func createPasswordLabelConstraint()
    {
        passwordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordLabel.centerYAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true
        passwordLabel.widthAnchor.constraint(equalTo: loginLabel.widthAnchor).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    func createPasswordTextFieldConstraint()
    {
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 2).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: loginLabel.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func createPasswordAgainLabelConstraint()
    {
        passwordAgainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordAgainLabel.centerYAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30).isActive = true
        passwordAgainLabel.widthAnchor.constraint(equalTo: loginLabel.widthAnchor).isActive = true
        passwordAgainLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    func createPasswordAgainTextFieldConstraint()
    {
        passwordAgainTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordAgainTextField.topAnchor.constraint(equalTo: passwordAgainLabel.bottomAnchor, constant: 2).isActive = true
        passwordAgainTextField.widthAnchor.constraint(equalTo: loginLabel.widthAnchor).isActive = true
        passwordAgainTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func createContinueRegButtonConstraint(button: UIButton)
    {
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 130).isActive = true
        button.widthAnchor.constraint(equalToConstant: 240).isActive = true
        button.heightAnchor.constraint(equalToConstant: 65).isActive = true
    }
    
    func applyShadowOnButtons(button: UIButton)
    {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.6
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
