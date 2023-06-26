//
//  sampleVApp.swift
//  sampleV
//
//  Created by SCI02122 on 2023/06/23.
//

import SwiftUI

@main
struct sampleVApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
