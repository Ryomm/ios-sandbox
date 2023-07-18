//
//  ContentView.swift
//  ConcurrencySampleApp

import SwiftUI

struct ContentView: View {
    @Binding var programs: [Program]
    @StateObject private var detailStore = ProgramDetailStore() // 番組詳細取得タイミングが番組一覧と別になるから、classを分けた
    @State var isLoading = true
    @State private var isPresentingNoteView = false
    @State private var notes: [Note] = []
    
    var body: some View {
        NavigationStack {
            List($programs) { $program in
                NavigationLink(
                    destination: ProgramDetailView(programDetail: detailStore.programDetail, isLoading: isLoading)
                        .task {
                            do {
                                try await detailStore.loadProgramDetail(of: program.id)
                                isLoading = false
                            } catch {
                                print("try again later")
                                isLoading = false
                            }
                        }
                ){
                    ProgramCardView(program: program)
                }
            }
            .navigationTitle("放送中の番組")
            .toolbar {
                Button( action: {
                    isPresentingNoteView = true
                }) {
                    Image(systemName: "pencil.circle.fill")
                }
                .accessibilityLabel("Add note")
            }
        }
        .sheet(isPresented: $isPresentingNoteView) {
            NoteView(notes: $notes, isPresentingNoteView: $isPresentingNoteView)
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
    let programDetail: ProgramDetail
    let isLoading: Bool
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView("データ取得中", value: 0.5)
                    .progressViewStyle(CircularProgressViewStyle())
            }
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
}

struct NoteView: View {
    @Binding var notes: [Note]
    @Binding var isPresentingNoteView: Bool
    @State private var newNote = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(notes) { note in
                    Text(note.note)
                }
                .onDelete { indices in
                    notes.remove(atOffsets: indices)
                }
                
                HStack {
                    TextField("新規メモ", text: $newNote)
                    Button(action: {
                        withAnimation {
                            let note = Note(note: newNote)
                            notes.append(note)
                            newNote = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add Note")
                    }
                    .disabled(newNote.isEmpty)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("閉じる") {
                    isPresentingNoteView = false
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
            ProgramDetailView(programDetail: ProgramDetail.sampleData, isLoading: false)
        }
    }
}

