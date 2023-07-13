//
//  NowOnAir.swift
//  ConcurrencySampleApp
//

import Foundation

// NowOnAirで使う
struct NowOnAir: Decodable {
    var nowonair_list: NowOnAirList

    struct NowOnAirList: Decodable {
        var g1: G1
    }

    struct G1: Decodable {
        var previous: Program
        var present: Program
        var following: Program
    }

    struct Program: Decodable {
        var id: String
        var start_time: String
        var end_time: String
        var title: String
    }
}

