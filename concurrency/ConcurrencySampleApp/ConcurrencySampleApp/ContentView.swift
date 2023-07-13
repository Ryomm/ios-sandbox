//
//  ContentView.swift
//  ConcurrencySampleApp
//
//  Created by SCI02122 on 2023/07/13.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowSheet = false
    
    var body: some View {
        let programs = NowOnAir(
            nowonair_list: NowOnAir.NowOnAirList(
                g1: NowOnAir.G1(
                    previous: NowOnAir.Program(
                        id: "2023071321477",
                        start_time: "2023-07-13T04:10:00+09:00",
                        end_time: "2023-07-13T04:20:00+09:00",
                        title: "時論公論　人種の多様性に揺れるアメリカ～違憲判決の波紋～"
                    ),
                    present: NowOnAir.Program(
                        id: "2023071321477",
                        start_time: "2023-07-13T04:10:00+09:00",
                        end_time: "2023-07-13T04:20:00+09:00",
                        title: "時論公論　人種の多様性に揺れるアメリカ～違憲判決の波紋～"
                    ),
                    following: NowOnAir.Program(
                        id: "2023071321477",
                        start_time: "2023-07-13T04:10:00+09:00",
                        end_time: "2023-07-13T04:20:00+09:00",
                        title: "時論公論　人種の多様性に揺れるアメリカ～違憲判決の波紋～"
                    )
                )
            )
        )
        
        let program = programs.nowonair_list.g1.present
        
        VStack {
            VStack {
                Text(program.title)
                    .font(.title2)
                HStack {
                    Text(program.start_time)
                    Text("〜")
                    Text(program.end_time)
                }
                .foregroundColor(.secondary)
            }
            .padding()
            .background(.background)
            .cornerRadius(4)
            .shadow(color: .gray.opacity(0.7), radius: 4)
            .sheet(isPresented: $isShowSheet) {
                ProgramDetailView()
            }
        }.padding()
    }
}

struct ProgramDetailView: View {
    let programDetail = ProgramDetail(
        g1: [
            ProgramDetail.G1(
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
        ]
    )
    
    let detail = programDetail.g1[0]
    
    var body: some View {
        VStack {
            Text(detail.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    var programs = NowOnAir(
        nowonair_list: NowOnAir.NowOnAirList(
            g1: NowOnAir.G1(
                previous: NowOnAir.Program(
                    id: "2023071321477",
                    start_time: "2023-07-13T04:10:00+09:00",
                    end_time: "2023-07-13T04:20:00+09:00",
                    title: "時論公論　人種の多様性に揺れるアメリカ～違憲判決の波紋～"
                ),
                present: NowOnAir.Program(
                    id: "2023071321477",
                    start_time: "2023-07-13T04:10:00+09:00",
                    end_time: "2023-07-13T04:20:00+09:00",
                    title: "時論公論　人種の多様性に揺れるアメリカ～違憲判決の波紋～"
                ),
                following: NowOnAir.Program(
                    id: "2023071321477",
                    start_time: "2023-07-13T04:10:00+09:00",
                    end_time: "2023-07-13T04:20:00+09:00",
                    title: "時論公論　人種の多様性に揺れるアメリカ～違憲判決の波紋～"
                )
            )
        )
    )
    
    static var previews: some View {
        ContentView()
    }
}

struct ProgramDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProgramDetailView()
    }
}
