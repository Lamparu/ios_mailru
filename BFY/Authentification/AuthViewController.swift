//
//  AuthViewController.swift
//  BFY
//
//  Created by Влада Приходченко on 20.10.2021.
//

import UIKit

class AuthViewController: UIViewController {

    let viewImage: UIImageView = {
        let image = UIImage(named: "BFY")
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let RegButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
        button.setTitle("Регистрация", for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 36)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let SignInButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        button.setTitle("Вход", for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 36)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = ""
        button.tintColor = UIColor(rgb: 0x6A7F60)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [viewImage, RegButton, SignInButton].forEach {view.addSubview($0)}
        
        setupBackground()
        setupShadows()
        setupConstraint()
        setupNavBarButton()
        
        navigationItem.hidesBackButton = true
        
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
    }
    
    private func setupShadows() {
        applyShadowOnButtons(button: RegButton)
        applyShadowOnButtons(button: SignInButton)
    }
    
    private func setupConstraint() {
        createViewImageConstraint()
        createButtonRegConstraint(button: RegButton)
        createButtonSignInConstraint(button: SignInButton, to: RegButton)
    }
    
    private func setupNavBarButton() {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    @objc private func didTapRegButton(_ sender: UIButton) {
        let regVC = RegistrationViewController()
        // let navController = UINavigationController(rootViewController: regVC)
//        self.present(navController, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(regVC, animated: true)
    }
    
    @objc private func didTapSignInButton(_ sender: UIButton) {
        let signinVC = SignInViewController()
        // let navController = UINavigationController(rootViewController: regVC)
//        self.present(navController, animated: true, completion: nil)
        self.navigationController?.pushViewController(signinVC, animated: true)
    }
    
    func applyShadowOnButtons(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.6
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
    }
    
    func createButtonSignInConstraint(button: UIButton, to: UIButton) {
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: to.bottomAnchor, constant: 30).isActive = true
    }
    
    func createButtonRegConstraint(button: UIButton) {
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: viewImage.bottomAnchor, constant: 50).isActive = true
    }
    
    
    func createViewImageConstraint() {
        viewImage.widthAnchor.constraint(equalToConstant: 400).isActive = true
        viewImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        viewImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -90).isActive = true
    }
    
    
}
