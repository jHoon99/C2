//
//  Answer.swift
//  c2
//
//  Created by 조재훈 on 4/15/25.
//

import Foundation
import SwiftData

@Model
final class Answer {
    var id: UUID
    var questionID: UUID
    var runnerNickname: String
    var selectedAnswerIndex: Int
    
    init(id: UUID, questionID: UUID, runnerNickname: String, selectedAnswerIndex: Int) {
        self.id = id
        self.questionID = questionID
        self.runnerNickname = runnerNickname
        self.selectedAnswerIndex = selectedAnswerIndex
    }
}


