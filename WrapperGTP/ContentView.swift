//
//  ContentView.swift
//  WrapperGTP
//
//  Created by Ugo Thevenin on 03/04/2025.
//

import SwiftUI
import MarkdownUI



struct ContentView: View {
    @StateObject private var vm = ContentViewModel()
 
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("fetch")
            {
                print("test \(vm.fetchFromAzure())")
            }.buttonStyle(.borderedProminent)
            ScrollView{
                Markdown(vm.messageFetched)
            }
            
        }
        .padding()
    }
}




#Preview {
    ContentView()
}
