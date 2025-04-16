//
//  MazeViewModel.swift
//  c2
//
//  Created by 조재훈 on 4/16/25.
//

import Foundation
import SwiftData


@Observable

final class MazeViewModel {
    
    // 현재 보여지는 질문의 인덱스
    private(set) var currentQuestionIndex = 0
    
    // 랜덤으로 선택된 7개의 질문 배열
    private(set) var selectedRandomQuestion: [Question] = []
    
    // 사용자가 선택한 답변들을 저장하는 배열
    private(set) var answers: [RunnerAnswer] = []
    
    private let runner: Runner
    
    // SwiftData 저장
    private let modelContext: ModelContext
    
    // 현재 표시되어야 하는 질문
    var currentQuestion: Question? {
        selectedRandomQuestion[currentQuestionIndex]
    }
    
    // 모든 질문에 답변했는지 여부
    var isComplete: Bool {
        currentQuestionIndex == selectedRandomQuestion.count
    }
    
    init(
        runner: Runner,
        modelContext: ModelContext
    ) {
        self.runner = runner
        self.modelContext = modelContext
    }
    
    
    
    
    
    
    
    
}
