//
//  Body.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 08.07.23.
//

import Foundation

struct Body: Codable {
    
    let tag: Apps
    let value: String
    
    init(tag: Apps = Apps.txt, value: String = "") {
        self.tag = tag
        self.value = value
    }
}

enum Apps: Codable {
    case nam
    case txt
}
