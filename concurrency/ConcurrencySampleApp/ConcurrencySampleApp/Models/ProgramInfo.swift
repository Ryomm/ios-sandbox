//
//  ProgramInfo.swift
//  ConcurrencySampleApp
//

import Foundation

struct ProgramInfo: Decodable {
    var list: G1
    
    struct G1: Decodable {
        var g1: [ProgramDetail]
    }
}

struct ProgramDetail: Decodable {
    var id: String
    var start_time: String
    var end_time: String
    var title: String
    var subtitle: String
    var content: String
    var act: String
    var program_url: String
    var hashtags: [String]
    
    init(id: String, start_time: String = "", end_time: String = "", title: String = "", subtitle: String = "", content: String = "", act: String = "", program_url: String = "", hashtags: [String] = []) {
        self.id = id
        self.start_time = start_time
        self.end_time = end_time
        self.title = title
        self.subtitle = subtitle
        self.content = content
        self.act = act
        self.program_url = program_url
        self.hashtags = hashtags
    }
}

extension ProgramDetail {
    static let sampleData: ProgramDetail = ProgramDetail(
        id: "2023071321477",
        start_time: "2023-07-13T04:10:00+09:00",
        end_time: "2023-07-13T04:20:00+09:00",
        title: "時論公論　人種の多様性に揺れるアメリカ～違憲判決の波紋～",
        subtitle: "アメリカの連邦最高裁による歴史的判断が波紋を広げている。人種の多様性確保を目的に、大学志願者の選考で少数派を優遇してきた措置が違憲に。今何が起きているのか解説。",
        content: "【解説】髙橋祐介",
        act: "【解説】髙橋祐介",
        program_url: "//nhk.jp/P1088",
        hashtags: [
            "#時論公論"
        ]
    )
}
