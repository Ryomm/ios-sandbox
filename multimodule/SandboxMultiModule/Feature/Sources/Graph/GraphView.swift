import Charts
import Models
import SwiftUI

public struct GraphView: View {
    var complexNums: [ComplexNum]
    
    public init(complexNums: [ComplexNum]) {
        self.complexNums = complexNums
    }
    
    public var body: some View {
        GroupBox("( 0 < x < 11, 0 < y < 11)") {
            Chart {
                ForEach(complexNums) { complexNum in
                    LineMark(
                        x: .value("real", complexNum.complexNum.real),
                        y: .value("imaginary", complexNum.complexNum.imaginary)
                    )
                }
            }
            .padding()
            .background(Color(.white))
            .cornerRadius(4)
        }
        .padding()
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(complexNums: [])
    }
}
