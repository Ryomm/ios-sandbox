
import ComposableArchitecture
import SwiftUI

struct Feature: ReducerProtocol {
    struct State: Equatable {
        var count = 0
    }

    enum Action: Equatable {
        case decrementButtonTapped
        case incrementButtonTapped
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none
        case .incrementButtonTapped:
            state.count += 1
            return .none
        }
    }
}

struct ContentView: View {
    let store: StoreOf<Feature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Button {
                    viewStore.send(.decrementButtonTapped)
                } label: {
                    Image(systemName: "minus")
                }

                Text("\(viewStore.count)")

                Button {
                    viewStore.send(.incrementButtonTapped)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            store: Store(initialState: Feature.State()) {
                Feature()
            }
        )
    }
}
