//
//  ContentView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 29/09/2023.
//

import SwiftUI
import ATProto
import Foundation


class Agent: ObservableObject, ATProtoXRPC.SessionProvider  {
    @Published var session: ATProtoXRPC.Session? = nil {
        didSet {
            let defaults = UserDefaults.standard
            if session == nil {
                defaults.removeObject(forKey: "session")
            } else {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(session) {
                    defaults.set(encoded, forKey: "session")
                }
            }
        }
    }
    
    // because we're using this class as the session provider,
    // create the client lazily - can't instanciate in the constructor
    private var sessionClient: XRPCSessionClient? = nil
    public var client: XRPCClient {
        get {
            if let client = self.sessionClient {
                return client
            } else {
                let url = URL(string:"https://bsky.social/xrpc")
                let client = XRPCSessionClient(baseURL: url!, urlSession: URLSession(configuration: .default), sessionProvider: self)
                self.sessionClient = client
                return client
            }
        }
    }
    
    init() {
        let defaults = UserDefaults.standard
        if let savedSession = defaults.object(forKey: "session") as? Data {
            let decoder = JSONDecoder()
            if let decodedSession = try? decoder.decode(ATProtoXRPC.Session.self, from: savedSession) {
                self.session = decodedSession
            }
        }
    }
}


struct ContentView: View {
    @StateObject var agent: Agent = Agent()
    
    var body: some View {
        Group {
            if agent.session != nil  {
                TabsView()
            }  else {
                LoginView()
            }
        }.environmentObject(agent)
    }
}

#Preview {
    ContentView()
}
