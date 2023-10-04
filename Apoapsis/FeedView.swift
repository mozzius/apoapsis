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
                Section {
                    FeedViewPostView(feedPost: feedPost)
                        .listRowInsets(.none)
                        .task() {
                            await vm.fetchMore(agent: agent, item: feedPost)
                        }
                }
            }
        }.task() {
            await vm.fetch(agent: agent)
        }.overlay {
            if !vm.error.isEmpty {
                Text(vm.error).foregroundColor(.red)
            } else if vm.isLoading && !vm.hasData {
                ProgressView().controlSize(.large)
            }
        }.refreshable {
            await vm.fetch(agent: agent)
        }
        .listStyle(.plain)
        .navigationTitle("Discover")
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FeedView().environmentObject(Agent())
        }
    }
}

struct FeedViewPostView: View {
    var feedPost: ATProto.App.Bsky.Feed.Defs.FeedViewPost
    @State var repostSheetOpen = false
    
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
                    
                }.lineLimit(1)
                
                if let body = feedPost.post.record.asPost?.text {
                    Text(body)
                        .padding(.bottom, 1.0)
                        .multilineTextAlignment(.leading)
                }
                
                if let embed = feedPost.post.embed {
                    Group {
                        switch embed {
                        case .type0(let images):
                            ForEach (images.images, id: \.fullsize) { image in
                                AsyncImage(url: URL(string: image.thumb)){ image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: .infinity)
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 4.0))
                                .padding(.trailing, 0.5)
                            }
                        case .type1(let external):
                            Text(external.external.uri)
                        case .type2(let record):
                            Text("2")
                        case .type3(let recordWithMedia):
                            Text("3")
                        }
                    }
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
                    }.onTapGesture {
                        repostSheetOpen = true
                    }.accessibilityLabel("Opens the repost/quote post menu")
                        .confirmationDialog("Repost or quote post",isPresented: $repostSheetOpen, titleVisibility: .hidden) {
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
                            .symbolVariant(feedPost.post.viewer?.like == nil ? .none : .fill)
                            .labelStyle(.iconOnly)
                        Text(String(feedPost.post.likeCount ?? 0))
                    }
                    
                }
            }
            
        }
    }
}
