//
//  FeedView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 04/10/2023.
//

import SwiftUI
import ATProto

struct FeedView: View {
    @EnvironmentObject var agent: Agent
    @StateObject var vm = FeedViewModel(feed: ATURI(string: "at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/whats-hot")!)
    
    var body: some View {
        
        List {
            ForEach(vm.posts, id: \.post.uri) { feedPost in
                FeedPostView(feedPost: feedPost)
                    .listRowInsets(.none)
                    .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                    .task() {
                        if feedPost.post.uri == vm.posts.last?.post.uri {
                            await vm.fetchMore(agent: agent, item: feedPost)
                        }
                    }
            }
        }.task() {
            await vm.fetch(agent: agent)
        }.overlay {
            if !vm.error.isEmpty {
                Text(vm.error).foregroundColor(.red)
            } else if vm.isLoading && !vm.hasData {
                ProgressView().controlSize(.large)
            }
        }.refreshable {
            await vm.fetch(agent: agent)
        }
        .listStyle(.plain)
        .navigationTitle("Discover")
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FeedView().environmentObject(Agent())
        }
    }
}
