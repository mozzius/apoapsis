//
//  HomeViewModel.swift
//  Apoapsis
//
//  Created by Samuel Newman on 10/11/2023.
//

import Foundation
import ATProto

@MainActor
class HomeViewModel: ObservableObject {
    @Published var preferences: ATProto.App.Bsky.Actor.Defs.Preferences = []
    @Published var allFeeds: [ATProto.App.Bsky.Feed.Defs.GeneratorView] = []
    @Published var pinnedFeeds: [ATProto.App.Bsky.Feed.Defs.GeneratorView] = []
    @Published var savedFeeds: [ATProto.App.Bsky.Feed.Defs.GeneratorView] = []
    @Published var error = ""
    @Published var hasPreferences = false
    @Published var hasFeeds = false
    @Published var isLoading = false
    
    init() {
    }
    
    
    func fetch(agent: Agent) async {
        isLoading = true
        do {
            let prefRequest = ATProtoAPI.App.Bsky.Actor.GetPreferences(parameters: .init())
            let prefResult = try await agent.client.send(prefRequest)
            self.preferences = prefResult.preferences
            self.hasPreferences = true
            
            for preference in self.preferences {
                if case let .type2(feedPrefs) = preference {
                    let feedRequest = ATProto.App.Bsky.Feed.GetFeedGenerators(parameters: .init(feeds: feedPrefs.saved))
                    let feedResult = try await agent.client.send(feedRequest)
                    self.allFeeds = feedResult.feeds
                    
                    for feed in self.allFeeds {
                        if feedPrefs.pinned.contains(where: {$0 == feed.uri}) {
                            pinnedFeeds.append(feed)
                        } else {
                            savedFeeds.append(feed)
                        }
                    }
                    
                    hasFeeds = true
                }
            }
            
            self.error = ""
        } catch {
            print(error)
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
