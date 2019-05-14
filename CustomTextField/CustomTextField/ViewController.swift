//
//  ViewController.swift
//  CustomTextField
//
//  Created by Yogesh Bharate on 9/10/18.
//  Copyright © 2018 Bharate, Yogesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var textField: CustomTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    textField.placeholder = "Hello User"
//    textField.isEnabled = false
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func showErrorButtonPressed(_ sender: Any) {
    textField.errorMessage = "Invalid Entry"
  }
}

