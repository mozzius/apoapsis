//
//  HomeView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 29/09/2023.
//

import SwiftUI

struct HomeView: View {
    
    
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.largeTitle)
        }.navigationTitle("Home View")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
