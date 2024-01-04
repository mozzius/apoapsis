//
//  FeedPostView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 10/11/2023.
//

import SwiftUI
import ATProto

struct FeedPostView: View {
    @EnvironmentObject var agent: Agent
    var feedPost: ATProto.App.Bsky.Feed.Defs.FeedViewPost
    @State var repostSheetOpen = false
    @State var like: ATURI?
    @State var showLike: Bool
    @State var likeCount: Int
    @State var repost: ATURI?
    @State var showRepost: Bool
    @State var repostCount: Int
    
    init(feedPost: ATProto.App.Bsky.Feed.Defs.FeedViewPost) {
        self.feedPost = feedPost
        self.like = feedPost.post.viewer?.like
        self.showLike = feedPost.post.viewer?.like != nil
        self.likeCount = feedPost.post.likeCount ?? 0
        self.repost = feedPost.post.viewer?.repost
        self.showRepost = feedPost.post.viewer?.repost != nil
        self.repostCount = feedPost.post.repostCount ?? 0
    }
    
    func toggleLike() async {
        do {
            if let rkey = like?.rkey {
                withAnimation {
                    showLike = false
                }
                let unlikeRequest = ATProtoAPI.Com.Atproto.Repo.DeleteRecord(input: .init(collection: "app.bsky.feed.like", repo: agent.did!, rkey: rkey))
                let _ = try await agent.client.send(unlikeRequest)
                like = nil
            } else {
                withAnimation {
                    showLike = true
                }
                let likeRequest = ATProtoAPI.Com.Atproto.Repo.CreateRecord(input: .init(collection: "app.bsky.feed.like", record: .type2(.init(createdAt: .now, subject: .init(cid: feedPost.post.cid, uri: feedPost.post.uri))), repo: agent.did!))
                let newLike = try await agent.client.send(likeRequest)
                like = newLike.uri
            }
        } catch {
            print(error)
            withAnimation {
                showLike = !showLike
            }
        }
    }
    
    func toggleRepost() async {
        do {
            if let rkey = repost?.rkey {
                withAnimation {
                    showRepost = false
                }
                let unlikeRequest = ATProtoAPI.Com.Atproto.Repo.DeleteRecord(input: .init(collection: "app.bsky.feed.repost", repo: agent.did!, rkey: rkey))
                let _ = try await agent.client.send(unlikeRequest)
                repost = nil
            } else {
                withAnimation {
                    showRepost = true
                }
                let likeRequest = ATProtoAPI.Com.Atproto.Repo.CreateRecord(input: .init(collection: "app.bsky.feed.repost", record: .type4(.init(createdAt: .now, subject: .init(cid: feedPost.post.cid, uri: feedPost.post.uri))), repo: agent.did!))
                let newLike = try await agent.client.send(likeRequest)
                repost = newLike.uri
            }
        } catch {
            print(error)
            withAnimation {
                showRepost = !showRepost
            }
        }
    }
    
    func setLikeCount() {
        var likeCount = feedPost.post.likeCount ?? 0
        if showLike {
            if feedPost.post.viewer?.like == nil {
                likeCount += 1
            }
        } else {
            if feedPost.post.viewer?.like != nil {
                likeCount -= 1
            }
        }
        self.likeCount = likeCount
    }
    
    func setRepostCount() {
        var repostCount = feedPost.post.repostCount ?? 0
        if showRepost {
            if feedPost.post.viewer?.repost == nil {
                repostCount += 1
            }
        } else {
            if feedPost.post.viewer?.repost != nil {
                repostCount -= 1
            }
        }
        self.repostCount = repostCount
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if let reason = feedPost.reason {
                switch reason {
                case .type0(let reposted):
                    HStack(alignment: .top) {
                        Image(systemName:"repeat")
                            .padding(.top, 2.0)
                            .frame(width: 48, alignment: .trailing)
                        Text((reposted.by.displayName ?? ("@" + reposted.by.handle)) + " reposted")
                    }
                    .bold()
                    .foregroundStyle(.secondary)
                }
            }
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
                
                VStack(alignment: .leading, spacing: 10.0) {
                    Group() {
                        if let displayName = feedPost.post.author.displayName {
                            Text(displayName).bold() + Text(" @" + feedPost.post.author.handle)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("@" + feedPost.post.author.handle).foregroundStyle(.secondary)
                        }
                        
                    }.lineLimit(1)
                    
                    if let body = feedPost.post.record.asPost?.text {
                        Text(body)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                            .padding(.top, -8.0)
                    }
                    
                    if let embed = feedPost.post.embed {
                        PostEmbedView(embed: embed)
                            .padding(.trailing)
                    }
                    
                    HStack {
                        HStack {
                            Label("Reply", systemImage: "bubble.left")
                                .labelStyle(.iconOnly)
                            Text(String(feedPost.post.replyCount ?? 0))
                        }
                        .frame(minWidth: 60.0, alignment: .leading)
                        .padding(.trailing)
                        
                        Menu {
                            Button {
                                Task {
                                    await toggleRepost()
                                }
                            } label: {
                                Label(repost == nil ? "Repost" : "Undo repost", systemImage: "repeat")
                            }
                            Button {
                                print("Quote")
                            } label: {
                                Label("Quote post", systemImage: "quote.bubble")
                            }
                        } label: {
                            HStack {
                                Label("Repost", systemImage: "repeat")
                                    .labelStyle(.iconOnly)
                                    .symbolEffect(.bounce.up.byLayer, value: showRepost)
                                Text(String(repostCount))
                                    .fontWeight(showRepost ? .bold : .regular)
                                    .contentTransition(.numericText(value: Double(repostCount)))
                                    .onChange(of: showRepost) {
                                        withAnimation {
                                            setRepostCount()
                                        }
                                    }
                            }
                            .foregroundStyle(showRepost ? .green : .primary)
                            .frame(minWidth: 60.0, alignment: .leading)
                            .padding(.trailing)
                        }
                        
                        Button {
                            Task {
                                await toggleLike()
                            }
                        } label: {
                            HStack {
                                Label("Like", systemImage: "heart")
                                    .symbolVariant(showLike ? .fill : .none)
                                    .labelStyle(.iconOnly)
                                    .contentTransition(.symbolEffect(.replace))
                                Text(String(likeCount))
                                    .fontWeight(showLike ? .bold : .regular)
                                    .contentTransition(.numericText(value: Double(likeCount)))
                                    .onChange(of: showLike) {
                                        withAnimation {
                                            setLikeCount()
                                        }
                                    }
                            }
                        }
                        .buttonStyle(.borderless)
                        .foregroundStyle(showLike ? .red : .primary)
                        .frame(minWidth: 60.0, alignment: .leading)
                        .padding(.trailing)
                        
                    }
                }
            }
        }
    }
}


#Preview {
    NavigationStack {
        if let post = getTestPost() {
            FeedPostView(feedPost: post)
                .padding()
                .environmentObject(Agent())
        } else {
            Text("Could not decode JSON")
        }
    }
}

