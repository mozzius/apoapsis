//
//  LoginView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 29/09/2023.
//

import SwiftUI
import Combine
import ATProto

struct LoginView: View {
    @EnvironmentObject var agent: Agent
    @State var identifier: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @State var isButtonDisabled: Bool = false
    
    
    private func logIn() {
        Task {
            if isButtonDisabled {
                return
            }
            isButtonDisabled = true
            
            do {
                let request = XRPCRequests.CreateSession(input: .init(identifier: identifier, password: password))
                let result = try await agent.client.send(request)
                agent.session = result.toSession()
                agent.did = result.did
            } catch {
                self.error = error.localizedDescription
            }
            
            isButtonDisabled = false
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Handle or email address", text: $identifier)
                        .textContentType(.username)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                } header: {
                    Text("Please sign in to continue.")
                } footer: {
                    error.isEmpty ? Text("You may want to log in using an App Password to ensure the safety of your account - however, this disables certain features.") : Text(error).foregroundColor(.red)
                }
                Button(action: {
                    logIn()
                }, label: {
                    Group {
                        if isButtonDisabled {
                            ProgressView()
                        } else {
                            Text("Log in").bold()
                        }
                    }.frame(maxWidth: .infinity)
                })
            }
            .navigationTitle("Sign in")
        }
    }
}

#Preview {
    LoginView().environmentObject(Agent())
}

