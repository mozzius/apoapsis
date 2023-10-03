//
//  ContentView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 29/09/2023.
//

import SwiftUI
import ATProto



class SessionProvider: ATProtoXRPC.SessionProvider, ObservableObject {
    @Published var session: ATProtoXRPC.Session? = nil
    
    init(session: ATProtoXRPC.Session? = nil) {
        self.session = session
    }
    
    func setSession(session: ATProtoXRPC.Session) {
        self.session = session
    }
}



class Agent: ObservableObject {
    @Published var sessionProvider = SessionProvider()
    @Published var client: XRPCClient
    
    init(session: ATProtoXRPC.Session? = nil) {
        let sessionProvider = SessionProvider(session: session)
        let url = URL(string:"https://bsky.social/xrpc")
        self.client = XRPCSessionClient(baseURL: url!, urlSession: URLSession(configuration: .default), sessionProvider: sessionProvider)
    }
}


struct ContentView: View {
    @StateObject var agent: Agent = Agent()
    
    var body: some View {
        NavigationStack {
            agent.sessionProvider.session != nil ? AnyView(HomeView()) : AnyView(LoginView())
        }.environmentObject(agent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
