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
    @StateObject private var vm = FeedViewModel()
    @State var uri: ATURI
    
    var body: some View {
        List {
            ForEach(vm.posts, id: \.post.uri) { feedPost in
                FeedPostView(feedPost: feedPost)
                    .alignmentGuide(.listRowSeparatorLeading) { _ in -30 }
                    .task() {
                        if feedPost.post.uri == vm.posts.last?.post.uri {
                            await vm.fetchMore(uri: uri, agent: agent)
                        }
                    }
            }
        }.task() {
            await vm.fetch(uri: uri, agent: agent)
        }.overlay {
            if !vm.error.isEmpty {
                Text(vm.error).foregroundColor(.red)
            } else if vm.isLoading && !vm.hasData {
                ProgressView().controlSize(.large)
            }
        }.refreshable {
            await vm.refresh(uri: uri, agent: agent)
        }
        .listStyle(.plain)
    }
}

#Preview{
    NavigationStack {
        FeedView(uri: ATURI(string: "at://did:plc:z72i7hdynmk6r22z27h6tvur/app.bsky.feed.generator/whats-hot")!).environmentObject(Agent())
    }
}

