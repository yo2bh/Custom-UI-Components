//
//  ViewController.swift
//  DatePicker
//
//  Created by Yogesh Bharate on 9/3/18.
//  Copyright © 2018 Bharate, Yogesh. All rights reserved.
//

import UIKit


enum DateType: Int {
  case past = 1
  case future = 2
}

class MainViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var selectedDates: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}


// MARK: - Text field Delegate
extension MainViewController: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    addDatePicker(textField: textField)
  }
  
  func addDatePicker(textField: UITextField) {
    let datePickerNib = UINib(nibName: "DatePickerView", bundle: nil)
    let datePickerView = datePickerNib.instantiate(withOwner: self, options: nil)[0] as? DatePickerView
    datePickerView?.inputview = textField
    textField.inputView = datePickerView
    datePickerView?.pickerDelegate = self
    
    switch textField.tag {
    case DateType.past.rawValue:
      datePickerView?.datePicker.maximumDate = Date().yesterday
      datePickerView?.datePicker.minimumDate = nil
    case DateType.future.rawValue:
      datePickerView?.datePicker.maximumDate = nil
      datePickerView?.datePicker.minimumDate = Date().tomorrow
    default:
      break
    }
  }
}

// MARK: - Custom date picker delegate
extension MainViewController: DatePickerViewDelegate {
  func doneButtonPressed(selectedDate: Date, inputView: UIView) {
    let textField = inputView as? UITextField
    textField?.text = selectedDate.toString()
    textField?.resignFirstResponder()
  }
  
  func cancelButtonPressed(inputView: UIView) {
    let textField = inputView as? UITextField
    textField?.resignFirstResponder()
  }
}


