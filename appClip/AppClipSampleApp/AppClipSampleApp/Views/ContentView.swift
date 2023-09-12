//
//  ContentView.swift
//  AppClipSampleApp
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        @State var toggle = false
        NavigationView {
            List {
                ForEach(0..<5) { index in
                    Toggle("Toggle", isOn: $toggle)
                        .toggleStyle(DefaultToggleStyle())
                    Text("Row \(index)")
                }
            }
        }
        .navigationTitle("ToDo")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


