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
    @Published var me: ATProto.App.Bsky.Actor.Defs.ProfileViewDetailed?
    
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
                    allFeeds = feedResult.feeds
                    
                    savedFeeds = []
                    for feed in allFeeds {
                        if feedPrefs.pinned.contains(where: {$0 != feed.uri}) {
                            savedFeeds.append(feed)
                        }
                    }
                    
                    pinnedFeeds = []
                    // have to do it in order of the pinned feeds
                    for uri in feedPrefs.pinned {
                        if let feed = allFeeds.first(where: {$0.uri == uri}) {
                            pinnedFeeds.append(feed)
                        }
                    }
                    
                    hasFeeds = true
                }
            }
            
            let meRequest = ATProtoAPI.App.Bsky.Actor.GetProfile(parameters: .init(actor: agent.did!))
            self.me = try await agent.client.send(meRequest)
            
            self.error = ""
        } catch {
            print(error)
            self.error = error.localizedDescription
        }
        isLoading = false
    }
}
