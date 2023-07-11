//
//  SettingsEditView.swift
//  RippleChat
//
//  Created by Severin Memmishofer on 11.07.23.
//

import SwiftUI

struct SettingsEditView: View {
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        Form {
            Section(header: Text("Personal Feed ID")) {
                //TextField("FeedID", text: $scrum.title)
            }
            Section(header: Text("Friends")) {
                
            }
        }
    }
}

struct SettingsEditView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsEditView()
    }
}
