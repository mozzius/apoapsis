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

func getTestPost() -> ATProto.App.Bsky.Feed.Defs.FeedViewPost? {
    let json = #"""
{
    "post": {
        "uri": "at://did:plc:p2cp5gopk7mgjegy6wadk3ep/app.bsky.feed.post/3kdtgqjirl52c",
        "cid": "bafyreidbkeuwxf7y7bzua7re65tpuw357yla6n4j4pxkez7mkdwqwri3ny",
        "author": {
            "did": "did:plc:p2cp5gopk7mgjegy6wadk3ep",
            "handle": "mozzius.dev",
            "displayName": "Fracture Considered Armful",
            "avatar": "https://cdn.bsky.app/img/avatar/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreifcop6pq373zewdqczka7f6f6553m74cm335p32ldrw2piv372t2i@jpeg",
            "viewer": {
                "muted": false,
                "blockedBy": false
            },
            "labels": []
        },
        "record": {
            "text": "Ok this is a banger app logo I won’t lie\n\n(don’t get excited, I’m just messing around with SwiftUI)",
            "$type": "app.bsky.feed.post",
            "embed": {
                "$type": "app.bsky.embed.images",
                "images": [
                    {
                        "alt": "App called Apoapsis\n\nIcon is a @ symbol in a planet with a starry backdrop",
                        "image": {
                            "$type": "blob",
                            "ref": {
                                "$link": "bafkreifcducruexy7jtjcn3lncjmais7pts6ulxamsdvidgnfujy7yyg7m"
                            },
                            "mimeType": "image/jpeg",
                            "size": 267048
                        },
                        "aspectRatio": {
                            "width": 1170,
                            "height": 607
                        }
                    }
                ]
            },
            "langs": [
                "en"
            ],
            "createdAt": 1699621300
        },
        "embed": {
            "$type": "app.bsky.embed.images#view",
            "images": [
                {
                    "thumb": "https://cdn.bsky.app/img/feed_thumbnail/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreifcducruexy7jtjcn3lncjmais7pts6ulxamsdvidgnfujy7yyg7m@jpeg",
                    "fullsize": "https://cdn.bsky.app/img/feed_fullsize/plain/did:plc:p2cp5gopk7mgjegy6wadk3ep/bafkreifcducruexy7jtjcn3lncjmais7pts6ulxamsdvidgnfujy7yyg7m@jpeg",
                    "alt": "App called Apoapsis\n\nIcon is a @ symbol in a planet with a starry backdrop",
                    "aspectRatio": {
                        "width": 1170,
                        "height": 607
                    }
                }
            ]
        },
        "replyCount": 2,
        "repostCount": 0,
        "likeCount": 6,
        "indexedAt": 1699621300,
        "viewer": {},
        "labels": []
    }
}
"""#.data(using: .utf8)!
    let decoder = JSONDecoder()
    do {
        return try decoder.decode(ATProto.App.Bsky.Feed.Defs.FeedViewPost.self, from: json)
    } catch {
        print(error)
        return nil
    }
}

