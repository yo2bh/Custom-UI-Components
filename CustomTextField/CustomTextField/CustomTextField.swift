//
//  CustomTextField.swift
//  CustomTextField
//
//  Created by Yogesh Bharate on 11/1/18.
//  Copyright © 2018 Bharate, Yogesh. All rights reserved.

import UIKit

class CustomTextField: UITextField {
  
  // MARK: - Variables
  private var title = UILabel()
  private var errorLabel = UILabel()
  
  private var placeHolderDefaultColor: UIColor?
  private var grayColor: String?
  private var greenColor: String?
  
  //property to be override for title padding from text
  var placeholderTopPadding: Double = 0
  var errorMessage: String {
    didSet {
      self.errorLabel.text = errorMessage
      self.errorLabel.textColor = UIColor.red
      updateBorderWidth()
      errorLabel.sizeToFit()
      self.updateErrorFrame()
      showErrorMessage()
    }
  }
  var errorMessageBottomPadding: Double = 0
  
  open var isLineColors = true
  
  // MARK: - Constants
  let border = CALayer()
  let unfocusedTextFieldLineWidth = CGFloat(1)
  let focusedTextFieldLineWidth = CGFloat(2)
  private let showAnimDuration = 0.3
  private let hideAnimDuration = 0.0
  private let placeHolderFont = UIFont(name: "Helvetica", size: 14.0)
  private let placeHolderDefaultFont = UIFont(name: "Helvetica", size: 18.0)
  
  // MARK: - Methods
  required init?(coder aDecoder: NSCoder) {
    self.errorMessage = ""
    super.init(coder: aDecoder)
    initializeVariables()
    setup()
  }
  
  override init(frame: CGRect) {
    self.errorMessage = ""
    super.init(frame: frame)
    setup()
  }
  
  private func initializeVariables() {
    placeHolderDefaultColor = UIColor.gray.withAlphaComponent(0.38)
  }
  
  private func configurePlaceholder() {
    self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "",
                                                    attributes: [
                                                      .foregroundColor: placeHolderDefaultColor!,
                                                      .font: placeHolderDefaultFont!
      ])
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let isResp = isFirstResponder
    
    // Should we show or hide the title label?
    if let txt = text, txt.isEmpty {
      // Hide
      hideTitle(animated: isResp)
    } else {
      // Show
      showTitle(isResp)
    }
    title.text = self.placeholder
    configurePlaceholder()
    self.updateFrame()
    
    if !errorMessage.isEmpty {
      showErrorMessage()
    }
  }
  
  fileprivate func setup() {
    borderStyle = UITextBorderStyle.none
    // Set up title label
    title.textColor = UIColor.gray.withAlphaComponent(0.38)
    title.alpha = 0.0
    title.font = placeHolderFont
    if let str = placeholder, !str.isEmpty {
      title.text = str
      title.sizeToFit()
    }
    self.decorateCell()
    title.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 19)
    self.addSubview(title)
    errorLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 19)
    self.addSubview(errorLabel)
  }
}

// MARK: - Animation methods
extension CustomTextField {
  
  private func showTitle(_ animated: Bool) {
    let dur = animated ? showAnimDuration : 0
    UIView.animate(withDuration: dur, delay: 0, options: [UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.curveEaseOut], animations: {
      // Animation
      self.title.alpha = 1.0
      var frame = self.title.frame
      
      if self.textAlignment == NSTextAlignment.center {
        self.title.textAlignment = .center
      } else if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft {
        //frame.origin.x = (self.frame.size.width)-(self.title.frame.size.width)
        self.title.textAlignment = .right
      }
      frame.origin.y = self.getTitlePadding()
      self.title.frame = frame
      self.updateBorderWidth()
      self.border.borderColor = self.getBorderColor()
    }, completion: nil)
  }
  
  private func showErrorMessage() {
    self.errorLabel.alpha = 1.0
    var frame = self.title.frame
    if self.textAlignment == NSTextAlignment.center {
      self.errorLabel.textAlignment = .center
    } else if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft {
      //frame.origin.x = (self.frame.size.width)-(self.title.frame.size.width)
      self.errorLabel.textAlignment = .right
    }
    frame.origin.y = self.getErrorTitlePadding()
    self.errorLabel.frame = frame
    border.borderWidth = focusedTextFieldLineWidth
    self.border.borderColor = UIColor.red.cgColor
  }
  
  private func hideTitle(animated: Bool) {
    let dur = animated ? hideAnimDuration : 0
    UIView.animate(withDuration: dur, delay: 0, options: [UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.curveEaseIn], animations: {
      // Animation
      var frame = self.title.frame
      frame.origin.y = self.title.font.lineHeight
      self.title.frame = frame
      self.title.alpha = 0.0
      self.updateBorderWidth()
      self.border.borderColor = self.getBorderColor()
    }, completion: nil)
  }
  
  private func getBorderColor() -> CGColor? {
    return self.isFirstResponder ? UIColor.green.cgColor : UIColor.gray.cgColor.copy(alpha: 0.12)
  }
}

// MARK: - Private Methods
extension CustomTextField {
  
  private func updateFrame() {
    let lineHeight = isFirstResponder ? focusedTextFieldLineWidth: unfocusedTextFieldLineWidth
    border.frame = CGRect(x: 0,
                          y: self.frame.size.height - lineHeight,
                          width: self.frame.size.width,
                          height: lineHeight)
    
    var newFrame = self.title.frame
    newFrame.size.width = self.frame.width
    self.title.frame = newFrame
  }
  
  private func updateErrorFrame() {
    let lineHeight = isFirstResponder ? focusedTextFieldLineWidth: unfocusedTextFieldLineWidth
    border.frame = CGRect(x: 0,
                          y: self.frame.size.height - lineHeight,
                          width: self.frame.size.width,
                          height: lineHeight)
    
    var newFrame = self.title.frame
    newFrame.size.width = self.frame.width
    self.errorLabel.frame = newFrame
  }
  
  private func getTitlePadding() -> CGFloat {
    
    var titlePadding = CGFloat(self.placeholderTopPadding != 0 ? self.placeholderTopPadding : 3.0)
    titlePadding += self.title.frame.size.height
    return titlePadding * -1
  }
  
  private func getErrorTitlePadding() -> CGFloat {
    var errorPadding = CGFloat(self.errorMessageBottomPadding != 0 ? self.errorMessageBottomPadding : 3.0)
    errorPadding += self.errorLabel.frame.size.height
    return errorPadding * 1
  }
  
  private func decorateCell() {
    border.borderColor = UIColor.gray.cgColor
    self.updateBorderWidth()
    self.layer.addSublayer(border)
    //Text alignment based on UI layout direction
    if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft {
      self.textAlignment = .right
    } else if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .leftToRight {
      self.textAlignment = .left
    } else {
      self.textAlignment = .center
    }
  }
  
  private func getKeyboardLanguage() -> String? {
    return "en_US"
  }
  
  override var textInputMode: UITextInputMode? {
    if let language = getKeyboardLanguage() {
      for inputMode in UITextInputMode.activeInputModes {
        if inputMode.primaryLanguage!.contains(language) {
          return inputMode
        }
      }
    }
    return super.textInputMode
  }
  
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    UIMenuController.shared.isMenuVisible = false
    return false
  }
  
//  private func getAppTheme () -> AppTheme? {
//    let appDelegate = UIApplication.shared.delegate as? AppDelegate
//    return appDelegate?.appTheme
//  }
  
  private func updateBorderWidth() {
    border.borderWidth = (isFirstResponder || !errorMessage.isEmpty) ? focusedTextFieldLineWidth : unfocusedTextFieldLineWidth
  }
}

