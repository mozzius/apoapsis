//
//  FollowingView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 11/11/2023.
//

import SwiftUI
import ATProto

struct TimelineView: View {
    @EnvironmentObject var agent: Agent
    @StateObject private var vm = TimelineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts, id: \.post.uri) { feedPost in
                FeedPostView(feedPost: feedPost)
                    .listRowInsets(.none)
                    .alignmentGuide(.listRowSeparatorLeading) { _ in -30 }
                    .task() {
                        if feedPost.post.uri == vm.posts.last?.post.uri {
                            await vm.fetchMore(agent: agent)
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
            await vm.refresh(agent: agent)
        }
        .listStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        TimelineView().environmentObject(Agent())
    }
}

