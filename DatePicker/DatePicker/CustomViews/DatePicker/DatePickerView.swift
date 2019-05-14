//
//  DatePickerView.swift
//  DatePicker
//
//  Created by Yogesh Bharate on 9/3/18.
//  Copyright © 2018 Bharate, Yogesh. All rights reserved.
//

import UIKit


protocol DatePickerViewDelegate {
  func doneButtonPressed(selectedDate: Date, inputView: UIView)
  func cancelButtonPressed(inputView: UIView)
}

class DatePickerView: UIView {
  
  // MARK: - Variables
  var inputview: UIView?
  var pickerDelegate: DatePickerViewDelegate?
  
  // MARK: - IBOutlets
  @IBOutlet weak var selectedDate: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!
  
  // MARK: - Methods
  override func awakeFromNib() {
    self.datePicker.addTarget(self, action: #selector(dateChanged(sender:)), for: .valueChanged)
    datePicker.locale = NSLocale(localeIdentifier: "en_US") as Locale
    selectedDate.text = datePicker.date.toString()
    datePicker.datePickerMode = .date
  }
  
  @objc func dateChanged(sender: UIDatePicker) {
    selectedDate.text = datePicker.date.toString()
  }
  
  // MARK: - IBActions
  @IBAction func doneButtonPressed() {
    pickerDelegate?.doneButtonPressed(selectedDate: datePicker.date, inputView: inputview!)
    self.removeFromSuperview()
  }
  
  @IBAction func cancelButtonPressed() {
    pickerDelegate?.cancelButtonPressed(inputView: inputview!)
    self.removeFromSuperview()
  }
}
