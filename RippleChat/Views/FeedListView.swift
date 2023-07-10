//
//  FeedListView.swift
//  RippleChat
//
//  Created by Sebastian Lenzlinger on 10.07.23.
//

import SwiftUI

struct FeedListView: View {
    @State var feeds: [Feed]
    
    var body: some View {
        Text("FeedListView")
    }
}

struct FeedListView_Previews: PreviewProvider {
    static var previews: some View {
        FeedListView(feeds: [])
    }
}
