//
//  ContentView.swift
//  JYExtensionExample
//
//  Created by Lu Lu on 2020/11/22.
//

import SwiftUI
import Extension

struct ContentView: View {
    var body: some View {
        Button("Test", action: {
            test()
        })
    }
    
    private func test(){
        
        let json = #"{"id": 12345, "title": "My First Video", "state": "reserved"}"#
        
        print(json.jy.toModel(Video.self))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Video: Decodable {
    enum State: String, Codable, DefaultValue {
        case streaming
        case archived
        case unknown
        static let defaultValue = Video.State.unknown
    }
    let id: Int
    let title: String
    @Default<Bool.False> var commentEnabled: Bool
    @Default<Bool.True> var publicVideo: Bool
    @Default<State> var state: State
}
