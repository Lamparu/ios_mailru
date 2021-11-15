//
//  TimerViewContoller.swift
//  BFY
//
//  Created by Полина Подчуфарова on 15.11.2021.
//

import UIKit

class TimerViewContoller: UIViewController {
    
    let stopwatchButton: UIButton = {
        let Button = UIButton()
     //   Button.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
        Button.setImage(UIImage(named: "stopwatch_off.png"), for: .normal)
        Button.setImage(UIImage(named: "stopwatch_on.png"), for: .selected)
    //    Button.layer.cornerRadius=50
    //    Button.layer.masksToBounds = true
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    } ()
    
    let timerButton: UIButton = {
        let Button = UIButton()
     //   Button.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
        Button.setImage(UIImage(named: "timer_off.png"), for: .normal)
        Button.setImage(UIImage(named: "timer_on.png"), for: .selected)
    //    Button.layer.cornerRadius=50
    //    Button.layer.masksToBounds = true
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    } ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0x6A7F60)
        self.view.addSubview(stopwatchButton)
        applystopwhatchButtons(button: stopwatchButton)
        
        self.view.addSubview(timerButton)
        applytimerButtons(button: timerButton)

        // Do any additional setup after loading the view.
    }
    func applystopwhatchButtons(button: UIButton)
        {
            button.layer.shadowColor = UIColor.black.cgColor
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -80 ).isActive = true
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -250 ).isActive = true
            button.heightAnchor.constraint(equalToConstant: 120).isActive = true
            button.widthAnchor.constraint(equalToConstant: 140).isActive = true
        }
    
    func applytimerButtons(button: UIButton)
        {
            button.layer.shadowColor = UIColor.black.cgColor
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 80 ).isActive = true
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -250 ).isActive = true
            button.heightAnchor.constraint(equalToConstant: 120).isActive = true
            button.widthAnchor.constraint(equalToConstant: 140).isActive = true
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
