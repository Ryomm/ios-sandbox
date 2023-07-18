//
//  Note.swift
//  ConcurrencySampleApp
//

import Foundation

struct Note: Identifiable {
    let id: UUID
    var note: String
    
    init(id: UUID = UUID(), note: String) {
        self.id = id
        self.note = note
    }
}

extension Note {
    static var emptyNote: Note {
        Note(note: "")
    }
}
