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
    
    var body: some View {
        switch embed {
        case .type0(let images):
            ImagesEmbedView(images: images)
        case .type1(let external):
            Text(external.external.uri.rawValue)
        case .type2(let record):
            Text("<Quote>")
        case .type3(let recordWithMedia):
            Text("<Quote with media>")
        }
    }
}

struct ImagesEmbedView: View {
    var images: ATProto.App.Bsky.Embed.Images.View
    
    var body: some View {
        switch images.images.count {
        case 1:
            let image = images.images[0]
            AsyncImage(url: URL(string: image.thumb)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: .infinity)
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
            .overlay(RoundedRectangle(cornerRadius: 4.0)
                .stroke(.gray, lineWidth: 0.33))
        case 2:
            let image1 = images.images[0]
            let image2 = images.images[1]
            HStack(spacing: 4.0) {
                AsyncImage(url: URL(string: image1.thumb)) { image in
                    image.centerCropped()
                } placeholder: {
                    Color.gray
                }
                .aspectRatio(1, contentMode: .fill)
                AsyncImage(url: URL(string: image2.thumb)) { image in
                    image.centerCropped()
                } placeholder: {
                    Color.gray
                }
                .aspectRatio(1, contentMode: .fill)
            }
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
        case 3:
            let image1 = images.images[0]
            let image2 = images.images[1]
            let image3 = images.images[2]
            HStack(spacing: 4.0) {
                AsyncImage(url: URL(string: image1.thumb)) { image in
                    image.centerCropped()
                } placeholder: {
                    Color.gray
                }
                .aspectRatio(1, contentMode: .fill)
                VStack(spacing: 4.0) {
                    AsyncImage(url: URL(string: image2.thumb)) { image in
                        image.centerCropped()
                    } placeholder: {
                        Color.gray
                    }
                    AsyncImage(url: URL(string: image3.thumb)) { image in
                        image.centerCropped()
                    } placeholder: {
                        Color.gray
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
        case 4:
            let image1 = images.images[0]
            let image2 = images.images[1]
            let image3 = images.images[2]
            let image4 = images.images[3]
            HStack(spacing: 4.0) {
                VStack(spacing: 4.0) {
                    AsyncImage(url: URL(string: image1.thumb)) { image in
                        image.centerCropped()
                    } placeholder: {
                        Color.gray
                    }
                    .aspectRatio(1, contentMode: .fill)
                    AsyncImage(url: URL(string: image2.thumb)) { image in
                        image.centerCropped()
                    } placeholder: {
                        Color.gray
                    }
                    .aspectRatio(1, contentMode: .fill)
                }
                VStack(spacing: 4.0) {
                    AsyncImage(url: URL(string: image3.thumb)) { image in
                        image.centerCropped()
                    } placeholder: {
                        Color.gray
                    }
                    .aspectRatio(1, contentMode: .fill)
                    AsyncImage(url: URL(string: image4.thumb)) { image in
                        image.centerCropped()
                    } placeholder: {
                        Color.gray
                    }
                    .aspectRatio(1, contentMode: .fill)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 4.0))
        default:
            Text("unreachable but it's insisting on being exhaustive")
        }
    }
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

#Preview {
    NavigationStack {
        List {
            Section {
                Text("Image (1 image):")
                if let post = getTestPost() {
                    PostEmbedView(embed: post.post.embed!)
                        .padding()
                        .environmentObject(Agent())
                }
                else {
                    Text("Could not decode JSON")
                }
            }
            Section {
                Text("Image (2 images):")
                if let post = getTestPostWith2Images() {
                    PostEmbedView(embed: post.post.embed!)
                        .padding()
                        .environmentObject(Agent())
                }
                else {
                    Text("Could not decode JSON")
                }
            }
            Section {
                Text("Image (3 images):")
                if let post = getTestPostWith3Images() {
                    PostEmbedView(embed: post.post.embed!)
                        .padding()
                        .environmentObject(Agent())
                }
                else {
                    Text("Could not decode JSON")
                }
            }
            Section {
                Text("Image (4 images):")
                if let post = getTestPostWith4Images() {
                    PostEmbedView(embed: post.post.embed!)
                        .padding()
                        .environmentObject(Agent())
                }
                else {
                    Text("Could not decode JSON")
                }
            }
        }.navigationTitle("Test embeds")
    }
}

