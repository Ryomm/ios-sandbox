//
//  ContentView.swift
//  ConcurrencySampleApp

import SwiftUI

struct ContentView: View {
    @Binding var programs: [Program]
    
    var body: some View {
        NavigationStack {
            List($programs) { $program in
                NavigationLink(destination: ProgramDetailView(program: program)){
                    ProgramCardView(program: program)
                }
            }
            .navigationTitle("放送中の番組")
            
        }
    }
}

struct ProgramCardView: View {
    let program: Program
    var body: some View {
        VStack(alignment: .leading) {
            Text(program.title)
                .font(.title2)
            HStack {
                Text(program.start_time)
                Text("〜")
                Text(program.end_time)
            }
            .font(.caption)
            .foregroundColor(.secondary)
            .accessibilityElement(children: .combine)
        }
        .padding()
    }
}

struct ProgramDetailView: View {
    let program: Program
    let programDetail: ProgramDetail = ProgramDetail.sampleData
    
    var body: some View {
        VStack {
            Text(programDetail.title)
                .font(.title)
            List {
                Section(header: Text("放送時間")) {
                    HStack{
                        Label("開始", systemImage: "timer")
                        Spacer()
                        Text(programDetail.start_time)
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                    HStack{
                        Label("終了", systemImage: "timer")
                        Spacer()
                        Text(programDetail.end_time)
                            .foregroundColor(.secondary)
                            .font(.caption)
                    }
                }
                
                Section(header: Text("放送内容")) {
                    Text(programDetail.subtitle)
                    Label(programDetail.content, systemImage: "note")
                    Label(programDetail.act, systemImage: "person")
                    Label("https:\(programDetail.program_url)", systemImage: "link")
                    HStack {
                        ForEach(programDetail.hashtags, id: \.self) { hashtag in
                            Text(hashtag)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(programs: .constant(Program.sampleData))
    }
}

struct ProgramDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProgramDetailView(program: Program.sampleData[0])
        }
    }
}
