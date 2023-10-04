//
//  FeedViewModel.swift
//  Apoapsis
//
//  Created by Samuel Newman on 04/10/2023.
//

import Foundation
import ATProto

@MainActor
class FeedViewModel: ObservableObject {
    @Published var posts: [ATProto.App.Bsky.Feed.Defs.FeedViewPost] = []
    @Published var cursor: String?
    @Published var error = ""
    @Published var hasData = false
    @Published var isLoading = false
    @Published var feed: ATURI
    
    init(feed: ATURI) {
        self.feed = feed
    }
    
    
    func fetch(agent: Agent) async {
        isLoading = true
        do {
            let request = ATProtoAPI.App.Bsky.Feed.GetFeed(parameters: .init(feed: self.feed))
            let result = try await agent.client.send(request)
            self.posts = result.feed
            self.cursor = result.cursor
            self.hasData = true
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    func fetchMore(agent: Agent, item: ATProto.App.Bsky.Feed.Defs.FeedViewPost) async {
        if cursor == nil || isLoading {return}
        if item.post.uri != self.posts.last?.post.uri {return}
        isLoading = true
        do {
            let request = ATProtoAPI.App.Bsky.Feed.GetFeed(parameters: .init(cursor: self.cursor, feed: self.feed))
            let result = try await agent.client.send(request)
            self.posts.append(contentsOf: result.feed)
            self.cursor = result.cursor
            self.hasData = true
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
