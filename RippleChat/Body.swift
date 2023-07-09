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
    
    init(tag: String, value: String) {
        self.tag = tag
        self.value = value
    }
}
