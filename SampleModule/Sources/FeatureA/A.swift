//
//  File.swift
//
//
//  Created on 2023/05/09.
//

import FeatureB
import Foundation

public struct A {
    public init() {}
    let b = B()

    public func sayHelloWithB() {
        b.sayHello()
    }
}
