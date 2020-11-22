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
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


