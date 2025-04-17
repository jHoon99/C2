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
    
    init(id: UUID, quewstionID: UUID, selectedIndex: Int) {
        self.id = id
        self.quewstionID = quewstionID
        self.selectedIndex = selectedIndex
    }
}
