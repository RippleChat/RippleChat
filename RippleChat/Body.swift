//
//  Body.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 08.07.23.
//

import Foundation

struct Body: Codable {
    
    let tag: String
    let value: String
    
    init(tag: Apps = Apps.txt, value: String = "") {
        self.tag = tag.description
        self.value = value
    }
}

enum Apps: Codable {
    case nam
    case txt
    
    var description : String {
      switch self {
      case .nam: return "nam"
      case .txt: return "txt"
      }
    }
}
