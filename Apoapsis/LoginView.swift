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
    @State  var identifier: String = ""
    @State  var password: String = ""
    @State  var error: String = ""
    @State  var isButtonDisabled: Bool = false
    
    
    private func logIn() {
        Task {
            isButtonDisabled = true
            
            do {
                let request = XRPCRequests.CreateSession(input: .init(identifier: identifier, password: password))
                let result = try await agent.client.send(request)
                agent.saveSession(session: result.toSession())
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
                    error.isEmpty ? Text("Please sign in to continue.") : Text(error).foregroundColor(.red)
                }
                Button(action: {
                    logIn()
                }, label: {
                    HStack(){
                        Spacer()
                        Text("Log in").bold().disabled(isButtonDisabled)
                        Spacer()
                    }
                })
            }
            .navigationTitle("Sign in")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(Agent())
    }
}
