//
//  NewFeedEntryView.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 10.07.23.
//

import SwiftUI

struct NewFeedEntryView: View {
    @State private var name: String = "Alice"

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter your name", text: $name)
            Text("Hello, \(name)!")
        }
    }
}

struct NewFeedEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewFeedEntryView()
    }
}
