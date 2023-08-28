//
//  ProgramStore.swift
//  ConcurrencySampleApp
//

import Foundation

@MainActor
class ProgramStore: ObservableObject {
    @Published var programs: [Program] = []
    
    func requestPrograms() async throws -> [Program] {
        let key = "phkMGeEfZk5BBJFyAwGSsRJytzasiaz7"
        let url = URL(string: "https://api.nhk.or.jp/v2/pg/now/130/g1.json?key=\(key)")!
        let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
        
        let article = try JSONDecoder().decode(NowOnAir.self, from: data)
        
        return [
            article.nowonair_list.g1.previous,
            article.nowonair_list.g1.present,
            article.nowonair_list.g1.following
        ]
    }
    
    func loadPrograms() async throws {
        Task {
            do {
                let response = try await requestPrograms()
//                print(response)
                self.programs = response
//                print("------------")
//                let s = try await requestProgramDetail(of: "2023071827653")
//                print(s)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

class ProgramDetailStore: ObservableObject {
    @Published var programDetail: ProgramDetail = .init(id: "")
    
    func requestProgramDetail(of id: String) async throws -> ProgramDetail {
        let key = "phkMGeEfZk5BBJFyAwGSsRJytzasiaz7"
        let url = URL(string: "https://api.nhk.or.jp/v2/pg/info/130/g1/\(id).json?key=\(key)")!
        let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
        
        let program = try JSONDecoder().decode(ProgramInfo.self, from: data)
        print("hoge")
        print(program)
        
        return program.list.g1[0]
    }
    
    func loadProgramDetail(of id: String) async throws {
        Task {
            do {
                let response = try await requestProgramDetail(of: id)
                self.programDetail = response
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
