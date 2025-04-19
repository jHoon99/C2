//
//  RunnerAnswer.swift
//  c2
//
//  Created by 조재훈 on 4/16/25.
//

import Foundation
import SwiftData

@Model

final class RunnerAnswer: Identifiable {
    var id: UUID
    var quewstionID: UUID
    var selectedIndex: Int
    var sessionID: UUID
    var timestamp: Date
    
    init(id: UUID, quewstionID: UUID, selectedIndex: Int, sessionID: UUID, timestamp: Date) {
        self.id = id
        self.quewstionID = quewstionID
        self.selectedIndex = selectedIndex
        self.sessionID = sessionID
        self.timestamp = timestamp
    }
}

