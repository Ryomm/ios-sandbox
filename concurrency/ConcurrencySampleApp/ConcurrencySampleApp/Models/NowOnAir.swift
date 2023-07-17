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
}


struct Program: Decodable, Identifiable {
    var id: String
    var start_time: String
    var end_time: String
    var title: String
    
    init(id: String, start_time: String, end_time: String, title: String) {
        self.id = id
        self.start_time = start_time
        self.end_time = end_time
        self.title = title
    }
}

extension Program {
    static let sampleData: [Program] = [
        Program(
            id: "2023071321477",
            start_time: "2023-07-13T04:10:00+09:00",
            end_time: "2023-07-13T04:20:00+09:00",
            title: "時論公論　人種の多様性に揺れるアメリカ～違憲判決の波紋～"
        ),
        Program(
            id: "2023071321477",
            start_time: "2023-07-13T04:10:00+09:00",
            end_time: "2023-07-13T04:20:00+09:00",
            title: "時論公論　人種の多様性に揺れるアメリカ～違憲判決の波紋～"
        ),
        Program(
            id: "2023071321477",
            start_time: "2023-07-13T04:10:00+09:00",
            end_time: "2023-07-13T04:20:00+09:00",
            title: "時論公論　人種の多様性に揺れるアメリカ～違憲判決の波紋～"
        )
    ]
}
