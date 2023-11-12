//
//  TimelineViewModel.swift
//  Apoapsis
//
//  Created by Samuel Newman on 11/11/2023.
//

import Foundation
import ATProto

@MainActor
class TimelineViewModel: ObservableObject {
    @Published var posts: [ATProto.App.Bsky.Feed.Defs.FeedViewPost] = []
    @Published var cursor: String?
    @Published var error = ""
    @Published var hasData = false
    @Published var isLoading = false
    
    func fetch(agent: Agent) async {
        posts = []
        hasData = false
        return await refresh(agent: agent)
    }
    
    func refresh(agent: Agent) async {
        isLoading = true
        cursor = nil
        do {
            let request = ATProtoAPI.App.Bsky.Feed.GetTimeline(parameters: .init())
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
    
    func fetchMore(agent: Agent) async {
        if cursor == nil || isLoading {return}
        isLoading = true
        do {
            let request = ATProtoAPI.App.Bsky.Feed.GetTimeline(parameters: .init(cursor: cursor))
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
