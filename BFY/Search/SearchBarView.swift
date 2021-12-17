//
//  SearchBarView.swift
//  BFY
//
//  Created by Анастасия Московчук on 25.11.2021.
//

import UIKit

final class SearchBarView: UIView {
    let searchBar: UISearchBar = UISearchBar()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupSearchBar()
        
        addSubview(searchBar)
//
        setupConstraint()
    }
    
    private func setupSearchBar() {
        searchBar.searchTextField.backgroundColor = UIColor(rgb: 0xfffcf4)
        searchBar.searchTextField.textColor = UIColor(rgb: 0x666568)
        
//        searchBar.barTintColor = UIColor(rgb: 0xfffcf4)
//        searchBar.tintColor = UIColor(rgb: 0x666568)
        searchBar.isTranslucent = true  // строка поиска полупрозрачная
//        searchBar.showsCancelButton = true
        
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Поиск книги",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x666568)]
        )
        
        searchBar.searchTextField.layer.cornerRadius = 1
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchTextField.layer.masksToBounds = true
        
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Отмена"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor(rgb: 0x666568)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraint() {
        searchBar.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOffset = CGSize(width: 0, height: 3)
        searchBar.layer.shadowOpacity = 0.4
        searchBar.layer.shadowRadius = 3
        searchBar.layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimationLoading() {
        searchBar.isLoading = true
    }
    
    func stopAnimationLoading() {
        searchBar.isLoading = false
    }
    
//    func setShowsCancelButton(i: Bool, animated: Bool) {
//        searchBar.setShowsCancelButton(i, animated: animated)
//    }
}

// Extension for search loading indicator
extension UISearchBar {
    public var textField: UITextField? {
        if #available(iOS 15.0, *) {
            return self.searchTextField
        } else {
            let subViews = subviews.flatMap { $0.subviews }
            guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
                return nil
            }
            return textField
        }
    }

    public var activityIndicator: UIActivityIndicatorView? {
        return textField?.leftView?.subviews.compactMap{ $0 as? UIActivityIndicatorView }.first
    }

    var isLoading: Bool {
        get {
            return activityIndicator != nil
        } set {
            if newValue {
                if activityIndicator == nil {
                    let newActivityIndicator = UIActivityIndicatorView(style: .medium)
                    newActivityIndicator.startAnimating()
                    newActivityIndicator.backgroundColor = textField?.backgroundColor ?? UIColor.white
                    textField?.leftView?.addSubview(newActivityIndicator)
                    let leftViewSize = textField?.leftView?.frame.size ?? CGSize.zero
                    newActivityIndicator.center = CGPoint(x: leftViewSize.width/2, y: leftViewSize.height/2)
                }
            } else {
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}


