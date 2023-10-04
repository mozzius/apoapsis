//
//  ContentView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 29/09/2023.
//

import SwiftUI
import ATProto
import Foundation


class SessionProvider: RawRepresentable, ATProtoXRPC.SessionProvider {
    var session: ATProtoXRPC.Session?
    
    required public init(rawValue: String) {
        if let data = rawValue.data(using: .utf8) {
            let result = try? JSONDecoder().decode(ATProtoXRPC.Session.self, from: data)
            self.session = result
        } else {
            self.session = nil
        }
    }
    
    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self.session),
              let result = String(data: data, encoding: .utf8)
        else {
            return "null"
        }
        return result
    }
}

class Agent: ObservableObject  {
    @AppStorage("session") var sessionProvider = SessionProvider()
    @Published var client: XRPCClient
    
    init() {
        let url = URL(string:"https://bsky.social/xrpc")
        self.client = XRPCSessionClient(baseURL: url!, urlSession: URLSession(configuration: .default), sessionProvider: self.sessionProvider)
    }
    
    func saveSession(session: ATProtoXRPC.Session?) {
        sessionProvider.session = session
        objectWillChange.send()
    }
}


struct ContentView: View {
    @StateObject var agent: Agent = Agent()
    
    var body: some View {
        Group {
            if $agent.sessionProvider.session != nil  {
                TabsView()
            }  else {
                LoginView()
            }
        }.environmentObject(agent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
