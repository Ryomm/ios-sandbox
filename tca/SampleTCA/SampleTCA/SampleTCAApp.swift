import SwiftUI
import ComposableArchitecture

@main
struct SampleTCAApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store(
                    initialState: Feature.State(),
                    reducer: Feature()
                )
            )
        }
    }
}
