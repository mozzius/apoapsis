//
//  ContentView.swift
//  Apoapsis
//
//  Created by Samuel Newman on 29/09/2023.
//

import Combine
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
    @Published var sessionProvider: SessionProvider
    @Published var client: XRPCClient
    
    var anyCancellable: AnyCancellable? = nil
    
    
    init(session: ATProtoXRPC.Session? = nil) {
        let sessionProvider = SessionProvider(session: session)
        self.sessionProvider = sessionProvider
        let url = URL(string:"https://bsky.social/xrpc")
        self.client = XRPCSessionClient(baseURL: url!, urlSession: URLSession(configuration: .default), sessionProvider: sessionProvider)
        
        // i don't understand swift. i think this allows nested observables
        anyCancellable = sessionProvider.objectWillChange.sink { [weak self] (_) in
            self?.objectWillChange.send()
        }
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
