//
//  TimerViewContoller.swift
//  BFY
//
//  Created by Полина Подчуфарова on 15.11.2021.
//
import UIKit
import SwiftUI


protocol ButtonDelegate: class {
    func onButtonTap(sender: UIButton)
}

class TimerViewContoller: UIViewController, ButtonDelegate {
    
 //  @IBOutlet weak var theContainer: UIView!
    
    
    let ClockSegmentControl: UISegmentedControl = {
    
        let mySegmentControl = UISegmentedControl(items: ["timer", "sec"])
        mySegmentControl.setImage(UIImage(named: "timer")?.withRenderingMode(.alwaysOriginal), forSegmentAt: 0)
        mySegmentControl.setImage(UIImage(named: "stopwatch")?.withRenderingMode(.alwaysOriginal), forSegmentAt:  1)
        mySegmentControl.selectedSegmentIndex = 0
        mySegmentControl.addTarget(self, action: #selector(selectedValue), for: .valueChanged)
        mySegmentControl.layer.shadowColor = UIColor.white.cgColor
        mySegmentControl.translatesAutoresizingMaskIntoConstraints = false
        return mySegmentControl
    } ()
    
    let endingButton: UIButton = {
        let playButton = UIButton()
        playButton.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
        let imageName = "endReading"
        let image = UIImage(named: imageName)
        playButton.setImage(UIImage(named: imageName), for: .normal)
        playButton.layer.cornerRadius=50
        playButton.layer.masksToBounds = true
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    } ()
    
    let backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor(rgb: 0xfffcf4)
        return backButton
    } ()
        
      
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0x6A7F60)
        //
        self.view.addSubview(ClockSegmentControl)
        self.selectedValue(target: ClockSegmentControl)
        
        self.view.addSubview(endingButton)
        createEndingButtons(button: endingButton)

       
        //back button
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        createClockSegmentControl()

        
        // Do any additional setup after loading the view.
    }
    
    func createClockSegmentControl(){
        ClockSegmentControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        ClockSegmentControl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        ClockSegmentControl.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -300).isActive = true
        ClockSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
 
    @objc private func selectedValue(target: UISegmentedControl) {
        
        if target == self.ClockSegmentControl{
            if target.selectedSegmentIndex == 0 {
                let childViewTimer = UIHostingController(rootView: TimerView())
                //timer view
                childViewTimer.view.frame = CGRect(x: 0, y: 200, width: 400 , height: 500)
                childViewTimer.view.backgroundColor = UIColor(rgb: 0x6A7F60)
                addChild(childViewTimer)
                self.view.addSubview(childViewTimer.view)
                childViewTimer.didMove(toParent: self)
                
                //childViewTimer.view.isActive = false
//                view.bringSubviewToFront(childViewTimer.view)
//                childViewStopwatch
                    
            } else {
                let childViewStopwatch = UIHostingController(rootView: StopwatchView())
                //stopwatch view
                childViewStopwatch.view.frame = CGRect(x: 0, y: 200, width: 400 , height: 500)
                childViewStopwatch.view.backgroundColor = UIColor(rgb: 0x6A7F60)
                addChild(childViewStopwatch)
                self.view.addSubview(childViewStopwatch.view)
                childViewStopwatch.didMove(toParent: self)
               
                
                
            }
        }
               
               
           }
    
    func createEndingButtons(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 76).isActive = true
        button.widthAnchor.constraint(equalToConstant: 244).isActive = true
    }
    
    @objc private func didTapRegButton(_ sender: UIButton) {
        let EndingScreenViewController = EndingScreenViewController()
        EndingScreenViewController.delegate = self
        let navController = UINavigationController(rootViewController: EndingScreenViewController)
        self.present(navController, animated: true, completion: nil)

    }
    
    func onButtonTap(sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
        }
    
}
