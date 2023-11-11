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
    @State var repost: ATURI?
    
    init(feedPost: ATProto.App.Bsky.Feed.Defs.FeedViewPost) {
        self.feedPost = feedPost
        self.like = feedPost.post.viewer?.like
        self.repost = feedPost.post.viewer?.repost
    }
    
    func toggleLike() async {
//        do {
//            if let rkey = like?.rkey {
//                let unlike = ATProtoAPI.Com.Atproto.Repo.DeleteRecord(input: .init(collection: "app.bsky.feed.like", repo: agent.did!, rkey: rkey))
//                let _ = try await agent.client.send(unlike)
//                like = nil
//            } else {
//                let like = ATProtoAPI.App.Bsky.Feed.Like(createdAt: .now, subject: .init(cid: feedPost.post.cid, uri: feedPost.post.uri))
//                let newLike = try await agent.client.send(like)
//                self.like = newLike
//            }
//        } catch {
//            print(error)
//        }
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
            
            VStack(alignment: .leading, spacing: 10.0) {
                Group() {
                    if let displayName = feedPost.post.author.displayName {
                        Text(displayName).bold() + Text(" @" + feedPost.post.author.handle)
                    } else {
                        Text("@" + feedPost.post.author.handle).foregroundColor(.gray)
                    }
                    
                }.lineLimit(1)
                
                if let body = feedPost.post.record.asPost?.text {
                    Text(body)
                        .multilineTextAlignment(.leading)
                }
                
                if let embed = feedPost.post.embed {
                    PostEmbedView(embed: embed)
                }
                
                HStack {
                    Label("Reply", systemImage: "bubble.left")
                        .labelStyle(.iconOnly)
                        .frame(minWidth: 30.0, alignment: .leading)
                        .padding(.trailing)
                    HStack {
                        Label("Repost", systemImage: "repeat")
                            .labelStyle(.iconOnly)
                        Text(String(feedPost.post.repostCount ?? 0))
                    }.foregroundColor(repost == nil ? nil : .green)
                        .onTapGesture {
                            repostSheetOpen = true
                        }.accessibilityLabel("Opens the repost/quote post menu")
                        .confirmationDialog("Repost or quote post", isPresented: $repostSheetOpen, titleVisibility: .hidden) {
                            Button("Repost") {
                                print("repost")
                            }
                            Button("Quote post") {
                                print("quote post")
                            }
                        }
                        .frame(minWidth: 60.0, alignment: .leading)
                        .padding(.trailing)
                    HStack {
                        Label("Like", systemImage: "heart")
                            .symbolVariant(like == nil ? .none : .fill)
                            .labelStyle(.iconOnly)
                            .contentTransition(.symbolEffect(.replace))
                        Text(String(feedPost.post.likeCount ?? 0))
                    }.foregroundColor(like == nil ? nil : .red)
                        .onTapGesture {
                            toggleLike()
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

