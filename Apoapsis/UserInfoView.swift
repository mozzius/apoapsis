//
//  UserInfoView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 12/11/2023.
//

import SwiftUI
import ATProto

struct UserInfoView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var agent: Agent
    var profile: ATProto.App.Bsky.Actor.Defs.ProfileViewDetailed?
    
    var body: some View {
        NavigationView {
            Form {
                if let me = profile {
                    Section {
                        LabeledContent("Display name", value: me.displayName ?? "")
                        LabeledContent("Handle", value: "@" + me.handle)
                    }
                    Section {
                        LabeledContent("DID", value: me.did)
                    }
                }
                Button {
                    agent.logOut()
                } label: {
                    Text("Log out")
                        .frame(maxWidth: .infinity)
                }.tint(.red)
            }
            .navigationTitle("User details")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .tint(.primary)
                    }
                }
            }
        }
    }
}
