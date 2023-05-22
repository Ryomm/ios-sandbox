import Charts
import ComplexModule
import SwiftUI

struct ComplexNum: Identifiable {
    var id: UUID = .init()
    var complexNum: Complex<Double>

    init(complexNum: Complex<Double>) {
        self.complexNum = complexNum
    }
}

class ComplexNums: ObservableObject {
    @Published var complexNums = [ComplexNum]()
}

struct SwiftUIView: View {
    @State var inputReal = 1
    @State var inputImaginary = 1
    @StateObject var complexNums = ComplexNums()

    var body: some View {
        VStack {
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
                self.complexNums.complexNums = []
                for n in 0 ..< 11 {
                    self.complexNums.complexNums.append(
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

            Spacer()

            GroupBox("( 0 < x < 11, 0 < y < 11)") {
                Chart {
                    ForEach(complexNums.complexNums) { complexNum in
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
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
