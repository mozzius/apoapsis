//
//  PostEmbedView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 10/11/2023.
//

import SwiftUI
import ATProto

struct PostEmbedView: View {
    var embed: Union4<ATProto.App.Bsky.Embed.Images.View, ATProto.App.Bsky.Embed.External.View, ATProto.App.Bsky.Embed.Record.View, ATProto.App.Bsky.Embed.RecordWithMedia.View>
    
    init(embed: Union4<ATProto.App.Bsky.Embed.Images.View, ATProto.App.Bsky.Embed.External.View, ATProto.App.Bsky.Embed.Record.View, ATProto.App.Bsky.Embed.RecordWithMedia.View>) {
        self.embed = embed
    }
    
    var body: some View {
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
            Text(external.external.uri.rawValue)
        case .type2(let record):
            Text("<Quote>")
        case .type3(let recordWithMedia):
            Text("<Quote with media>")
        }
    }
}

struct PostEmbedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            if let post = getTestPost() {
                List {
                    Section {
                        Text("Image (1 image):")
                        PostEmbedView(embed: post.post.embed!)
                            .padding()
                            .environmentObject(Agent())
                    }
                }
            } else {
                Text("Could not decode JSON")
            }
        }
        
    }
}
