//
//  MainBookViewController.swift
//  BFY
//
//  Created by Влада Приходченко on 28.10.2021.
//

import UIKit

class MainBookViewController: UIViewController {

    let viewRectangle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(rgb: 0xD8D1BC)
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(viewRectangle)
        view.backgroundColor = .red
        
        createRectViewConstraint()
        // Do any additional setup after loading the view.
    }
    
    func createRectViewConstraint()
    {
        viewRectangle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        viewRectangle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewRectangle.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewRectangle.widthAnchor.constraint(equalToConstant: 150).isActive = true
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
