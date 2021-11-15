//
//  SignInViewController.swift
//  BFY
//
//  Created by Влада Приходченко on 14.11.2021.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Электронная почта/Логин"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.textAlignment = .center
        textField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.resignFirstResponder()
        textField.isSecureTextEntry.toggle()
        
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
    
    let rememberButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        view.addSubview(viewEmptyRectangle)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(line1)
        view.addSubview(line2)
        view.addSubview(signInLabel)
       
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        
        
        createRectViewConstraint()
        createLoginTextFieldConstraint()
        createPasswordTextFieldConstraint()
        createLine1Constraint()
        createLine2Constraint()
        createSignInLabelConstraint()
        
        
        let continueSignInButton = UIButton()
        //continueSignInButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        continueSignInButton.setTitle("Войти", for: .normal)
        continueSignInButton.titleLabel?.textAlignment = .center
        //continueSignInButton.titleEdgeInsets
        //continueSignInButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 32)
        continueSignInButton.setTitleColor(UIColor(rgb: 0xfffcf4), for: .normal)
        continueSignInButton.backgroundColor = UIColor(rgb: 0x6A7F60)
        continueSignInButton.layer.cornerRadius = 20
        continueSignInButton.translatesAutoresizingMaskIntoConstraints = false
        applyShadowOnButtons(button: continueSignInButton)
        
        let forgetButton = UIButton()
        forgetButton.setTitle("Забыли пароль?", for: .normal)
        forgetButton.titleLabel?.textAlignment = .center
        forgetButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        forgetButton.setTitleColor(.black, for: .normal)
        forgetButton.layer.cornerRadius = 20
        forgetButton.layer.borderColor = UIColor(rgb: 0x6A7F60).cgColor
        forgetButton.layer.borderWidth = 2
        forgetButton.translatesAutoresizingMaskIntoConstraints = false
        
        //let rememberButton = UIButton()
        rememberButton.translatesAutoresizingMaskIntoConstraints = false
        rememberButton.setImage(UIImage(named: "box_empty"), for: .normal)
        rememberButton.addTarget(self, action: #selector(didTapRememberButton), for: .touchUpInside)
        
        let rememberTextButton = UIButton()
        rememberTextButton.translatesAutoresizingMaskIntoConstraints = false
        rememberTextButton.setTitle("Запомнить меня", for: .normal)
        rememberTextButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        rememberTextButton.setTitleColor(.black, for: .normal)
        rememberTextButton.addTarget(self, action: #selector(didTapTextRememberButton), for: .touchUpInside)
        
        
        view.addSubview(continueSignInButton)
        view.addSubview(forgetButton)
        
        view.addSubview(rememberTextButton)
        view.addSubview(rememberButton)
        
        createContinueSignInButtonConstraint(button: continueSignInButton)
        createForgetButtonConstraint(button: forgetButton)
        createRememberButtonConstraint(button: rememberButton, forgetBtn: forgetButton)
        createRememberTextButtonConstraint(button: rememberTextButton, imageBtn: rememberButton)
    }
    
    func createRectViewConstraint()
    {
        viewEmptyRectangle.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40).isActive = true
        viewEmptyRectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewEmptyRectangle.heightAnchor.constraint(equalToConstant: 380).isActive = true
        viewEmptyRectangle.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func createLoginTextFieldConstraint()
    {
        loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginTextField.centerYAnchor.constraint(equalTo: viewEmptyRectangle.topAnchor, constant: 60).isActive = true
        loginTextField.widthAnchor.constraint(equalToConstant: 255).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    func createPasswordTextFieldConstraint()
    {
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 50).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: loginTextField.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    func createLine1Constraint()
    {
        line1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        line1.centerYAnchor.constraint(equalTo: loginTextField.bottomAnchor).isActive = true
        line1.widthAnchor.constraint(equalTo: loginTextField.widthAnchor).isActive = true
        line1.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func createLine2Constraint()
    {
        line2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        line2.centerYAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        line2.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor).isActive = true
        line2.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func createSignInLabelConstraint()
    {
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
    
    func createContinueSignInButtonConstraint(button: UIButton)
    {
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: viewEmptyRectangle.bottomAnchor, constant: -20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 64).isActive = true
        button.widthAnchor.constraint(equalToConstant: 240).isActive = true
        
    }
    
    func createForgetButtonConstraint(button: UIButton)
    {
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 27).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func createRememberButtonConstraint(button: UIButton, forgetBtn: UIButton)
    {
        button.centerXAnchor.constraint(equalTo: viewEmptyRectangle.leftAnchor, constant: 70).isActive = true
        button.centerYAnchor.constraint(equalTo: forgetBtn.bottomAnchor, constant: 38).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
    }
    
    func createRememberTextButtonConstraint(button: UIButton, imageBtn: UIButton)
    {
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
        button.leftAnchor.constraint(equalTo: imageBtn.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: imageBtn.centerYAnchor).isActive = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return false
    }
    
    func applyShadowOnButtons(button: UIButton)
    {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.6
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
    }
    
    private func changeRememberButtonState()
    {
        if rememberButton.isSelected {
            rememberButton.setBackgroundImage(UIImage(named: "box_filled"), for: .normal)
            rememberButton.isSelected = false
        } else {
            rememberButton.setBackgroundImage(UIImage(named: "box_empty"), for:.normal)
            rememberButton.isSelected = true
        }
    }
    
    @objc private func didTapRememberButton(_ sender: UIButton) {
        
        changeRememberButtonState()
        //sender.isSelected = !sender.isSelected
    }
    
    @objc private func didTapTextRememberButton(_ sender: UIButton) {
        changeRememberButtonState()
        //sender.isSelected = !sender.isSelected
    }
    
//    @objc private func didTapRememberButton(_ sender: UIButton, buttonImage: UIButton, buttonText: UIButton) {
//        if buttonImage.isSelected || buttonText.isSelected {
//            buttonImage.setBackgroundImage(UIImage(named: "box_filled"), for: .normal)
//            buttonImage.isSelected = false
//            buttonText.isSelected = false
//        } else {
//            buttonImage.setBackgroundImage(UIImage(named: "box_empty"), for:.normal)
//            buttonImage.isSelected = true
//            buttonText.isSelected = true
//        }
//        //sender.isSelected = !sender.isSelected
//    }


}
