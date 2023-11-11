//
//  TabsView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 04/10/2023.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView() {
            HomeView().tabItem {
                Label("Home", systemImage: "house")
            }
            WIPView().tabItem {
                Label("Notifications", systemImage: "bell")
            }
            WIPView().tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
        }
    }
}

#Preview {
    TabsView().environmentObject(Agent())
}

