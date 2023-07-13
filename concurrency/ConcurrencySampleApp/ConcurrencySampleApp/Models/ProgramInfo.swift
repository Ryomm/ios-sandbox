//
//  ProgramInfo.swift
//  ConcurrencySampleApp
//
//  Created by SCI02122 on 2023/07/13.
//

import Foundation

struct ProgramDetail: Decodable {
    var g1: [G1]
    
    struct G1: Decodable {
        var id: String
        var start_time: String
        var end_time: String
        var title: String
        var subtitle: String
        var content: String
        var act: String
        var program_url: String
        var hashtags: [String]
    }
}
