//
//  ViewController.swift
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xfffcf4)
        
        view.addSubview(viewImage)
        
        createViewImageConstraint()
        
        let RegButton = UIButton()
        RegButton.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
        RegButton.setTitle("Регистрация", for: .normal)
        RegButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 36)
        RegButton.setTitleColor(.black, for: .normal)
        RegButton.translatesAutoresizingMaskIntoConstraints = false
        applyShadowOnButtons(button: RegButton)
        
        let SignInButton = UIButton()
        SignInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        SignInButton.setTitle("Вход", for: .normal)
        SignInButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 36)
        SignInButton.setTitleColor(.black, for: .normal)
        SignInButton.translatesAutoresizingMaskIntoConstraints = false
        applyShadowOnButtons(button: SignInButton)
        
        view.addSubview(RegButton)
        view.addSubview(SignInButton)
        
        createButtonRegConstraint(button: RegButton)
        createButtonSignInConstraint(button: SignInButton, to: RegButton)
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
//        backButton.image = UIImage(named: "box_filled")
        backButton.tintColor = UIColor(rgb: 0x6A7F60)
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
