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
    
    let continueSignInButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.textAlignment = .center
//        button.titleEdgeInsets
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 32)
        button.setTitleColor(UIColor(rgb: 0xfffcf4), for: .normal)
        button.backgroundColor = UIColor(rgb: 0x6A7F60)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let forgetButton: UIButton = {
        let button = UIButton()
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
    
    let rememberButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "box_empty"), for: .normal)
        button.addTarget(self, action: #selector(didTapRememberButton), for: .touchUpInside)
        return button
    }()
    
    let rememberTextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Запомнить меня", for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapTextRememberButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        
        [viewEmptyRectangle, loginTextField, passwordTextField,
         line1, line2, signInLabel, continueSignInButton,
         forgetButton, rememberTextButton, rememberButton].forEach {view.addSubview($0)}
    
        setupBackground()
        setupConstraints()
        setupShadows()
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
        createRememberButtonConstraint()
        createRememberTextButtonConstraint()
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
        forgetButton.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 27).isActive = true
        forgetButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        forgetButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func createRememberButtonConstraint() {
        rememberButton.centerXAnchor.constraint(equalTo: viewEmptyRectangle.leftAnchor, constant: 70).isActive = true
        rememberButton.centerYAnchor.constraint(equalTo: forgetButton.bottomAnchor, constant: 38).isActive = true
        rememberButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        rememberButton.widthAnchor.constraint(equalTo: rememberButton.heightAnchor).isActive = true
    }
    
    func createRememberTextButtonConstraint() {
        rememberTextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rememberTextButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        rememberTextButton.leftAnchor.constraint(equalTo: rememberButton.centerXAnchor).isActive = true
        rememberTextButton.centerYAnchor.constraint(equalTo: rememberButton.centerYAnchor).isActive = true
    }
    
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
    
    private func changeRememberButtonState() {
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
    
    @objc private func didTapContinueButton(_ sender: UIButton) {
        let bookVC = MainBookViewController()
//         let navController = UINavigationController(rootViewController: regVC)
//        self.present(navController, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(bookVC, animated: true)
    }

}
