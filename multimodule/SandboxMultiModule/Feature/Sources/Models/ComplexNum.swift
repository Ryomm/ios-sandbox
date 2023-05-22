@_exported import ComplexModule
import Foundation
import SwiftUI

public struct ComplexNum: Identifiable {
    public var id: UUID = .init()
    public var complexNum: Complex<Double>

    public init(complexNum: Complex<Double>) {
        self.complexNum = complexNum
    }
}
