//
//  TimerViewContoller.swift
//  BFY
//
//  Created by Полина Подчуфарова on 15.11.2021.
//
import UIKit

func maskRoundedImage(image: UIImage, radius: CGFloat) -> UIImage {
       let imageView: UIImageView = UIImageView(image: image)
       let layer = imageView.layer
       layer.masksToBounds = true
       layer.cornerRadius = radius
       UIGraphicsBeginImageContext(imageView.bounds.size)
       layer.render(in: UIGraphicsGetCurrentContext()!)
       let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       return roundedImage!
   }

class TimerViewContoller: UIViewController {
    
    let stopwatchButton: UIButton = {
        let Button = UIButton()
        Button.addTarget(self, action: #selector(didTapTimerButton), for: .valueChanged)
        Button.setImage(UIImage(named: "stopwatch.png"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    } ()
    
    let timerButton: UIButton = {
        let Button = UIButton()
        Button.addTarget(self, action: #selector(didTapTimerButton), for: .valueChanged)
        Button.setImage(UIImage(named: "timer.png"), for: .normal)
        Button.translatesAutoresizingMaskIntoConstraints = false
        return Button
    } ()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0x6A7F60)
        self.view.addSubview(stopwatchButton)
        applystopwhatchButtons(button: stopwatchButton)
        applyShadowOnButtons(button: stopwatchButton)
        
        self.view.addSubview(timerButton)
        applytimerButtons(button: timerButton)
        applyShadowOnButtons(button: timerButton)
        
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor(rgb: 0xfffcf4)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        // Do any additional setup after loading the view.
    }
    func applystopwhatchButtons(button: UIButton) {
            button.layer.shadowColor = UIColor.black.cgColor
            button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 260 ).isActive = true
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -250 ).isActive = true
            button.heightAnchor.constraint(equalToConstant: 96).isActive = true
            button.widthAnchor.constraint(equalToConstant: 96).isActive = true
   
        }
    
    func applytimerButtons(button: UIButton) {
            button.layer.shadowColor = UIColor.black.cgColor
            button.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 34 ).isActive = true
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -250 ).isActive = true
            button.heightAnchor.constraint(equalToConstant: 96).isActive = true
            button.widthAnchor.constraint(equalToConstant: 96).isActive = true
        }
    
    @objc private func didTapStopwatchButton(_ sender: UIButton) {
             //  let Timer = TimerViewContoller()
              // self.navigationController?.pushViewController(Timer, animated: true)
           }
    
    @objc private func didTapTimerButton(_ sender: UIButton) {
               //let Timer = TimerViewContoller()
              // self.navigationController?.pushViewController(Timer, animated: true)
               
               
           }
     func applyShadowOnButtons(button: UIButton) {
         button.layer.shadowColor = UIColor.black.cgColor
         button.layer.shadowOffset = CGSize(width: 0, height: 3)
         button.layer.shadowOpacity = 0.6
         button.layer.shadowRadius = 3
         button.layer.masksToBounds = false
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
