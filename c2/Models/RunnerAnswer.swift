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
    var questionText: String //question질문이 아니라 qustionId를 string값으로 가져오기 위해 넣어줌
    var selectedText: String
    var selectedEmoji: String
    
    init(id: UUID, quewstionID: UUID, selectedIndex: Int, sessionID: UUID, timestamp: Date, questionText: String, selectedText: String, selectedEmoji: String) {
        self.id = id
        self.quewstionID = quewstionID
        self.selectedIndex = selectedIndex
        self.sessionID = sessionID
        self.timestamp = timestamp
        self.questionText = questionText
        self.selectedText = selectedText
        self.selectedEmoji = selectedEmoji
    }
}

