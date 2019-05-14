//
//  Models.swift
//  AppThemeing
//
//  Created by Yogesh Bharate on 8/21/18.
//  Copyright © 2018 Bharate, Yogesh. All rights reserved.
//

import Foundation

struct Color: Decodable {
  
  private enum ColorKeys: String, CodingKey {
    case background, navigationBar
  }
  
  let background: String
  let navigationBar: String
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: ColorKeys.self)
    background = try values.decode(String.self, forKey: .background)
    navigationBar = try values.decode(String.self, forKey: .navigationBar)
  }
}

struct Text: Decodable {
  var headerText: String
  
  private enum TextKeys: String, CodingKey {
    case headerText
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: TextKeys.self)
    headerText = try values.decode(String.self, forKey: .headerText)
  }
}

struct Images: Decodable {
  var buttonImage: String
  
  private enum ImageKeys: String, CodingKey {
    case buttonImage
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: ImageKeys.self)
    buttonImage = try values.decode(String.self, forKey: .buttonImage)
  }
}


struct CustomTheme: Decodable {
  
  var color: Color
  var text: Text?
  var image: Images?
  
  private enum RootKeys: String, CodingKey {
    case Color, Text, Images
  }
  
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: RootKeys.self)
    color = try values.decode(Color.self, forKey: .Color)
    text = try values.decodeIfPresent(Text.self, forKey: .Text)
    image = try values.decodeIfPresent(Images.self, forKey: .Images)
  }
}
