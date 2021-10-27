//
//  ViewController.swift
//  BFY
//
//  Created by Влада Приходченко on 20.10.2021.
//

import UIKit

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

class ViewController: UIViewController {

    let viewImage: UIImageView = {
        let imageName = "BFY.png"
        let image = UIImage(named: imageName)
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
        RegButton.setTitle("Регистрация", for: .normal)
        RegButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 36)
        RegButton.setTitleColor(.black, for: .normal)
        RegButton.translatesAutoresizingMaskIntoConstraints = false
        applyShadowOnButtons(button: RegButton)
        
        let SignInButton = UIButton()
        SignInButton.setTitle("Вход", for: .normal)
        SignInButton.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 36)
        SignInButton.setTitleColor(.black, for: .normal)
        SignInButton.translatesAutoresizingMaskIntoConstraints = false
        applyShadowOnButtons(button: SignInButton)
        
        view.addSubview(RegButton)
        view.addSubview(SignInButton)
        
        createButtonRegConstraint(button: RegButton)
        createButtonSignInConstraint(button: SignInButton, to: RegButton)
        
    }
    
    func applyShadowOnButtons(button: UIButton)
    {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.6
        button.layer.shadowRadius = 3
        button.layer.masksToBounds = false
    }
    
    func createButtonSignInConstraint(button: UIButton, to: UIButton)
    {
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: to.bottomAnchor, constant: 30).isActive = true
    }
    
    func createButtonRegConstraint(button: UIButton)
    {
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: viewImage.bottomAnchor, constant: 50).isActive = true
    }
    
    
    func createViewImageConstraint()
    {
        viewImage.widthAnchor.constraint(equalToConstant: 400).isActive = true
        viewImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        viewImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -90).isActive = true
    }
    
}
