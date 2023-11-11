//
//  FeedPostView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 10/11/2023.
//

import SwiftUI
import ATProto

struct FeedPostView: View {
    var feedPost: ATProto.App.Bsky.Feed.Defs.FeedViewPost
    @State var repostSheetOpen = false
    @State var like: ATURI?
    @State var repost: ATURI?
    
    init(feedPost: ATProto.App.Bsky.Feed.Defs.FeedViewPost) {
        self.feedPost = feedPost
        self.like = feedPost.post.viewer?.like
        self.repost = feedPost.post.viewer?.repost
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
                    
                }.lineLimit(1)
                
                if let body = feedPost.post.record.asPost?.text {
                    Text(body)
                        .padding(.bottom, 1.0)
                        .multilineTextAlignment(.leading)
                }
                
                if let embed = feedPost.post.embed {
                    PostEmbedView(embed: embed)
                }
                
                HStack {
                    Label("Reply", systemImage: "bubble.left")
                        .labelStyle(.iconOnly)
                        .frame(minWidth: 25.0, alignment: .leading)
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
                        Text(String(feedPost.post.likeCount ?? 0))
                    }.foregroundColor(like == nil ? nil : .red)
                        .onTapGesture {
                            
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

