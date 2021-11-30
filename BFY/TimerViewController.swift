//
//  TimerViewContoller.swift
//  BFY
//
//  Created by Полина Подчуфарова on 15.11.2021.
//
import UIKit
import SwiftUI


class TimerViewContoller: UIViewController {
    
 //  @IBOutlet weak var theContainer: UIView!
    
    var imageArray = [UIImage(named: "stopwatch"),UIImage(named: "timer")]
    var Arrya = ["timer", "stopwatch"]
    let childView=UIHostingController(rootView: ContentView())
    
    let ClockSegmentControl: UISegmentedControl = {
    
        let mySegmentControl = UISegmentedControl(items: ["timer", "sec"])
        mySegmentControl.setImage(UIImage(named: "timer")?.withRenderingMode(.alwaysOriginal), forSegmentAt: 0)
        mySegmentControl.setImage(UIImage(named: "stopwatch")?.withRenderingMode(.alwaysOriginal), forSegmentAt:  1)
        mySegmentControl.addTarget(self, action: #selector(selectedValue), for: .valueChanged)
        mySegmentControl.layer.shadowColor = UIColor.white.cgColor
//        Button.setDividerImage(UIImage(named: "stopwatch"), for: .normal)
        mySegmentControl.frame = CGRect(x: 100, y: 70, width: 200 , height: 100)
        mySegmentControl.translatesAutoresizingMaskIntoConstraints = false
        //mySegmentControl.setWidth( , forSegmentAt: 0)
        //mySegmentControl.backgroundColor = UIColor(rgb: 0x6A7F60)
        return mySegmentControl
    } ()
    
    let StopWatch: UIView = {
        let simpleView = UIView()
        simpleView.backgroundColor = UIColor.white
        simpleView.translatesAutoresizingMaskIntoConstraints = false
        simpleView.frame = CGRect(x: 0, y: 250, width: 400 , height: 400)
        return simpleView
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
        
        self.view.addSubview(ClockSegmentControl)
        
        //stopWatch view
        self.view.addSubview(StopWatch)
        
        //timer view
        childView.view.frame = CGRect(x: 0, y: 250, width: 400 , height: 400)
        childView.view.backgroundColor = UIColor(rgb: 0x6A7F60)
        addChild(childView)
        self.view.addSubview(childView.view)
        
        //back button 
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        
        // Do any additional setup after loading the view.
    }
    
 
    @objc private func selectedValue(target: UISegmentedControl) {
//            applyShadowOnButtons(button: stopwatchButton)
               //let Timer = TimerViewContoller()
              // self.navigationController?.pushViewController(Timer, animated: true)
        
        if target == self.ClockSegmentControl{
            if target.selectedSegmentIndex == 0 {
                view.bringSubviewToFront(childView.view)
                    
            } else {
                view.bringSubviewToFront(StopWatch)
                
                
            }
        }
               
               
           }
     func applyShadowOnButtons(button: UIButton) {
         button.layer.shadowColor = UIColor.black.cgColor
         button.layer.shadowOffset = CGSize(width: 0, height: 3)
         button.layer.shadowOpacity = 0.6
         button.layer.shadowRadius = 3
         button.layer.masksToBounds = false
     }
    
}
