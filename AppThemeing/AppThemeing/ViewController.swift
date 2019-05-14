//
//  ViewController.swift
//  AppThemeing
//
//  Created by Yogesh Bharate on 8/20/18.
//  Copyright © 2018 Bharate, Yogesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var appDelegate: AppDelegate?
  
  @IBOutlet weak var okButton: UIButton!
  @IBOutlet weak var foreView: UIView!
  @IBOutlet weak var imageView: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    appDelegate = UIApplication.shared.delegate as? AppDelegate
    configureUI()
  }
  
  func configureUI() {
    if let  customTheme = readFromPlist() {
      self.view.backgroundColor = UIColor(rgb: Int(customTheme.color.background)!)
      self.imageView.image = UIImage(named:  (customTheme.image?.buttonImage)!)
      self.title = customTheme.text?.headerText
    }
  }
  
  func readFromPlist() -> CustomTheme? {
    if let setting = Bundle.main.object(forInfoDictionaryKey: "AppSetting") as? String,
      let path = Bundle.main.url(forResource: setting, withExtension: "plist"),
      let data = try? Data(contentsOf: path) {
      let decoder = PropertyListDecoder()
      return try? decoder.decode(CustomTheme.self, from: data)
    }
    return nil
  }
  
  func readPlistUsingDictionary() {
    if let setting = Bundle.main.object(forInfoDictionaryKey: "AppSetting") as? String,
      let path = Bundle.main.path(forResource: setting, ofType: "plist"),
      let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any],
      let color = dictionary["Color"] as? [String: Any],
      let background = color["background"] as? String,
      let navigationColor = color["navigationBar"] as? String {
      print(color)
      print(background)
      self.view.backgroundColor = UIColor(rgb: Int(background)!)
      self.navigationController?.navigationBar.backgroundColor = UIColor(rgb: Int(navigationColor)!)
    }
  }
  
  @IBAction func redIconButtonPressed() {
    appDelegate?.changeIcon("red")
  }
  
  @IBAction func blueIconButtonPressed() {
    appDelegate?.changeIcon()
  }
  
  @IBAction func greenIconButtonPressed() {
    appDelegate?.changeIcon("green")
  }
}

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

