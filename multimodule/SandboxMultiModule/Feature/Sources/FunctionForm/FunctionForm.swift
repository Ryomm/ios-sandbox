import Models
import SwiftUI

public struct FunctionFormView: View {
    @Binding var complexNums: [ComplexNum]
    @State var inputReal = 1
    @State var inputImaginary = 1

    public init(complexNums: Binding<[ComplexNum]>, inputReal: Int = 1, inputImaginary: Int = 1) {
        self._complexNums = complexNums
        self.inputReal = inputReal
        self.inputImaginary = inputImaginary
    }

    public var body: some View {
        HStack {
            TextField(
                "num1",
                value: self.$inputReal,
                format: .number
            )
            .keyboardType(.numberPad)
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(4)
            Text("x").padding()
            Spacer()
            Text("+").padding()
            Spacer()
            TextField(
                "num2",
                value: self.$inputImaginary,
                format: .number
            )
            .keyboardType(.numberPad)
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(4)
            Text("yi").padding()
        }
        .padding()

        Button(action: {
            complexNums = []
            for n in 0 ..< 11 {
                complexNums.append(
                    ComplexNum(complexNum: Complex<Double>(Double(self.inputReal) * Double(n), Double(self.inputImaginary) * Double(n)))
                )
            }
        }) {
            Text("グラフ生成").font(.headline)
        }
        .padding()
        .background(Color(.systemGray))
        .foregroundColor(Color(.white))
        .cornerRadius(4)
    }
}

struct FunctionFormView_Previews: PreviewProvider {
    static var previews: some View {
        FunctionFormView(complexNums: .constant([]))
    }
}
