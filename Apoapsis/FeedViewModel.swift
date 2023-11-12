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
    
    func fetch(uri: ATURI, agent: Agent) async {
        posts = []
        hasData = false
        return await refresh(uri: uri, agent: agent)
    }
    
    func refresh(uri: ATURI, agent: Agent) async {
        isLoading = true
        cursor = nil
        do {
            let request = ATProtoAPI.App.Bsky.Feed.GetFeed(parameters: .init(feed: uri))
            let result = try await agent.client.send(request)
            posts = result.feed
            cursor = result.cursor
            hasData = true
            error = ""
        } catch {
            print(error)
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    func fetchMore(uri: ATURI, agent: Agent) async {
        if cursor == nil || isLoading {return}
        isLoading = true
        do {
            let request = ATProtoAPI.App.Bsky.Feed.GetFeed(parameters: .init(cursor: cursor, feed: uri))
            let result = try await agent.client.send(request)
            posts.append(contentsOf: result.feed)
            cursor = result.cursor
            hasData = true
        } catch {
            print(error)
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
