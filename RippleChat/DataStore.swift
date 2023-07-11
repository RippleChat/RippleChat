//
//  DataStore.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 11.07.23.
//

import SwiftUI
import Foundation

class DataStore: ObservableObject {
    @Published var personalID: String
    @Published var friends: [String]
    @Published var feeds: [Feed]
    
    init(personalID: String = "", friends: [String] = [], feeds: [Feed] = []) {
        self.personalID = personalID
        self.friends = friends
        self.feeds = feeds
    }
}
