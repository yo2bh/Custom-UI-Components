//
//  ViewController.swift
//  AlertSheet-Color-Text
//
//  Created by Yogesh Bharate on 8/19/18.
//  Copyright © 2018 Bharate, Yogesh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet weak var alertViewButton: UIButton!
  @IBOutlet weak var alertSheetButton: UIButton!
  
  // MARK: - Constants
  let questions = [
    "What is your favorite movie ?",
    "Who is your favorite actor ?",
    "What is the first name of your favorite uncle ?",
    "Where did you meet your spouse ?",
    "What is your nick name ?"
  ]
  
  // MARK: - Variables
  var appDelegate: AppDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    appDelegate = UIApplication.shared.delegate as? AppDelegate
  }
  
  @IBAction func showAlertViewButtonPressed(_ sender: Any) {
    showAlert()
  }
  
  @IBAction func showAlertSheetButtonPressed(_ sender: Any) {
//    showAlert(UIAlertControllerStyle.actionSheet)
    customFontAlert()
  }
  
    func showAlert(_ preferredStyle: UIAlertController.Style = UIAlertController.Style.alert) {
    let alertView = UIAlertController(title: "", message: "Please select one of security question.", preferredStyle: preferredStyle)
    // \u{f004}
    for question in questions {
      let action = UIAlertAction(title: question, style: .default, handler: { _ in
        self.showToast(message: question)
      })
      alertView.addAction(action)
    }
    
    
    alertView.view.tintColor = UIColor.red
    self.present(alertView, animated: true, completion: nil)
  }
  
  func customFontAlert() {
    let alert = UIAlertController(title: "", message: "Select Question", preferredStyle: .actionSheet)
    
    let action = UIAlertAction(title: "Exo2-Bold", style: .default, handler: nil)
    let action1 = UIAlertAction(title: "Exo2-Light", style: .default, handler: nil)
    let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
    
    let attributedText = NSMutableAttributedString(string: "Exo2-Bold")
    let attributedText1 = NSMutableAttributedString(string: "Exo2-Light")
    
    let range = NSRange(location: 0, length: attributedText.length)
    attributedText.addAttribute(NSAttributedString.Key.kern, value: 1.5, range: range)
    attributedText.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Exo2-Bold", size: 20.0)!, range: range)
    
    let range1 = NSRange(location: 0, length: attributedText1.length)
    attributedText1.addAttribute(NSAttributedString.Key.kern, value: 1.5, range: range1)
    attributedText1.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Exo2-Light", size: 20.0)!, range: range1)
    
    alert.addAction(action)
    alert.addAction(action1)
    alert.addAction(cancel)
    
    present(alert, animated: true, completion: nil)
    
    // this has to be set after presenting the alert, otherwise the internal property __representer is nil
    guard let label = action.value(forKey: "__representer") else { return }
    let value1 = (label as AnyObject).value(forKey:"label") as? UILabel
    value1?.attributedText = attributedText
    
    guard let label1 = action1.value(forKey: "__representer") else { return }
    let value2 = (label1 as AnyObject).value(forKey:"label") as? UILabel
    value2?.attributedText = attributedText1
    
  }
  
  func showToast(message : String) {
    let toastLabel = UILabel(frame: CGRect(x: 20,
                                           y: self.view.frame.size.height-50,
                                           width: view.frame.size.width/2, height: 50))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.textAlignment = .center;
    toastLabel.font = UIFont(name: "", size: 10.0)
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.adjustsFontSizeToFitWidth = true
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    toastLabel.sizeToFit()
    toastLabel.numberOfLines = 0
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
      toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
      toastLabel.removeFromSuperview()
    })
  }
}

