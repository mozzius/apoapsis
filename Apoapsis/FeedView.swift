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
                FeedViewPostView(feedPost: feedPost)
                    .task() {
                        await vm.fetchMore(agent: agent, item: feedPost)
                    }
            }
        }.task() {
            await vm.fetch(agent: agent)
        }.overlay {
            if vm.isLoading && !vm.hasData {
                ProgressView().controlSize(.large)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Discover")
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView().environmentObject(Agent())
    }
}

struct FeedViewPostView: View {
    var feedPost: ATProto.App.Bsky.Feed.Defs.FeedViewPost
    
    init(feedPost: ATProto.App.Bsky.Feed.Defs.FeedViewPost) {
        self.feedPost = feedPost
    }
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: feedPost.post.author.avatar ?? "")) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 48, height: 48)
            .scaledToFit()
            .clipShape(Circle())
            .padding(.trailing, 2.0)
            
            VStack(alignment: .leading) {
                Group() {
                    if let displayName = feedPost.post.author.displayName {
                        Text(displayName).bold() + Text(" @" + feedPost.post.author.handle)
                    } else {
                        Text("@" + feedPost.post.author.handle).foregroundColor(.gray)
                    }
                    
                }.lineLimit(1).padding(.bottom, 1.0)
                
                if let body = feedPost.post.record.asPost?.text {
                    Text(body)
                        .padding(.bottom, 1.0)
                        .multilineTextAlignment(.leading)
                }
                
                HStack() {
                    Label("Reply", systemImage: "bubble.left")
                        .labelStyle(.iconOnly)
                    
                    Label(String(feedPost.post.repostCount ?? 0), systemImage: "repeat")
                    
                    Label(String(feedPost.post.likeCount ?? 0), systemImage: "heart")
                        .symbolVariant(feedPost.post.viewer?.like == nil ? .none : .fill)
                        
                }
            }
            
        }
    }
}
