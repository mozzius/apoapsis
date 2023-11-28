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
    @State private var isPresentingUserInfo = false
    // @State var query: String = ""
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List(selection: $selectedFeed) {
                if vm.hasFeeds {
                    NavigationLink(value: "following") {
                        FeedImage()
                        Text("Following")
                    }
                    Section("Favourites") {
                        ForEach(vm.pinnedFeeds, id: \.uri) { feed in
                            NavigationLink(value: feed.uri.toString()) {
                                FeedImage(src: feed.avatar)
                                Text(feed.displayName)
                            }
                        }
                    }
                    Section("All feeds") {
                        ForEach(vm.savedFeeds, id: \.uri) { feed in
                            NavigationLink(value: feed.uri.toString()) {
                                FeedImage(src: feed.avatar)
                                Text(feed.displayName)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Bluesky")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresentingUserInfo = true
                    } label: {
                        if let avatar = vm.me?.avatar {
                            AsyncImage(url: URL(string: avatar)) { image in
                                image.resizable()
                            } placeholder: {
                                Image(systemName: "person.crop.circle")
                            }
                            .frame(width: 32, height: 32)
                            .scaledToFit()
                            .clipShape(Circle())
                        } else {
                            Image(systemName: "person.crop.circle")
                                .imageScale(.large)
                        }
                    }
                    .sheet(isPresented: $isPresentingUserInfo) {
                        UserInfoView(profile: vm.me)
                    }
                }
            }
            // .searchable(text: $query, prompt: "Search feeds")
        } detail: {
            if selectedFeed == "following" {
                TimelineView()
                    .navigationTitle("Following")
            } else if let feed = ATURI(string: selectedFeed ?? "") {
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

struct FeedImage: View {
    var src: String?
    
    var body: some View {
        Group {
            if let url = src {
                AsyncImage(url: URL(string: url)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 20, height: 20)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 2.0))
            } else {
                RoundedRectangle(cornerRadius: 2.0)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.blue)
            }
        }
    }
}

#Preview {
    HomeView().environmentObject(Agent())
}

