import FunctionForm
import Graph
import Models
import SwiftUI

public struct HomeView: View {
    @State private var complexNums: [ComplexNum] = []
    
    public init() {}
    
    public var body: some View {
        VStack {
            FunctionFormView(complexNums: $complexNums)
            Spacer()
            GraphView(complexNums: complexNums)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
