//
//  HomeView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 29/09/2023.
//

import SwiftUI
import ATProto

struct HomeView: View {
    @State var selectedFeed: String? = "following"
    @EnvironmentObject var agent: Agent
    @StateObject var vm = HomeViewModel()
    @State private var visibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(selection: $selectedFeed) {
                if vm.hasFeeds {
                    NavigationLink(value: "following") {
                        RoundedRectangle(cornerRadius: 2.0)
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.blue)
                        Text("Following")
                    }
                    Section("Favourites") {
                        ForEach(vm.pinnedFeeds, id: \.uri) { feed in
                            NavigationLink(value: feed.uri.toString()) {
                                AsyncImage(url: URL(string: feed.avatar ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 16, height: 16)
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 2.0))
                                Text(feed.displayName)
                            }
                        }
                    }
                    Section("All feeds") {
                        ForEach(vm.savedFeeds, id: \.uri) { feed in
                            NavigationLink(value: feed.uri.toString()) {
                                AsyncImage(url: URL(string: feed.avatar ?? "")) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 16, height: 16)
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 2.0))
                                Text(feed.displayName)
                            }
                        }
                    }
                }
            }.navigationTitle("Bluesky")
        } detail: {
            if selectedFeed == "following" {
                Text("Following feed goes here")
            } else if let feed = ATURI(string: selectedFeed!) {
                if let feedInfo = vm.allFeeds.first(where: {$0.uri == feed}) {
                    FeedView(uri: feed)
                        .id(feed)
                        .navigationTitle(feedInfo.displayName)
                } else {
                    Text("Could not find feed somehow???")
                }
            } else {
                Text("No feed selected")
            }
        }.task {
            await vm.fetch(agent: agent)
        }.navigationSplitViewStyle(.balanced)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(Agent())
    }
}
