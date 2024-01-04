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
    @State var copied = false
    
    var body: some View {
        NavigationView {
            Form {
                if let me = profile {
                    Section {
                        Text(me.displayName ?? me.handle)
                        Text("@" + me.handle)
                    } header: {
                        Text("Display name & handle")
                    }
                    if let desc = me.description {
                        Section {
                            Text(desc)
                        } header: {
                            Text("Description")
                        }
                    }
                    Section {
                        Text(copied ? "Copied!" : me.did)
                            .contentTransition(.numericText())
                            .onTapGesture {
                                UIPasteboard.general.string = me.did
                                withAnimation {
                                    copied = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    withAnimation {
                                        copied = false
                                    }
                                }
                                
                            }
                    } header: {
                        Text("DID")
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
                            .tint(.secondary)
                            .controlSize(.extraLarge)
                    }
                }
            }
        }
    }
}
