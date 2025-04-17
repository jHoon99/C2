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
    
    // SwiftData 저장
    private let modelContext: ModelContext?
    
    private let runner: Runner
    
    // 현재 보여지는 질문의 인덱스
    private(set) var currentQuestionIndex = 0
    
    // 랜덤으로 선택된 7개의 질문 배열
    private(set) var selectedRandomQuestion: [Question] = []
    
    // 사용자가 선택한 답변들을 저장하는 배열
    // 배열 인덱스로만 비교하는것은 안될거같아서 키값을 사용
    private(set) var answerDictionary: [UUID: Int] = [:]
    
    
    
    
    // 현재 표시되어야 하는 질문
    var currentQuestion: Question? {
        selectedRandomQuestion[currentQuestionIndex]
    }
    
    // 모든 질문에 답변했는지 여부
    var isComplete: Bool {
        currentQuestionIndex == selectedRandomQuestion.count
    }
    
    // 현재까지의 답변 수
    var answerdCount: Int {
        answerDictionary.count
    }
    
    init(
        runner: Runner,
        modelContext: ModelContext?
    ) {
        self.runner = runner
        self.modelContext = modelContext
    }
    
    // 답변하지 않은 질문들을 로드하고 랜덤하게 7개 선택
    func loadQuestion() {
        do {
            // 기존 답변들 조회
            let descriptor = FetchDescriptor<RunnerAnswer>()
            let answers = try modelContext!.fetch(descriptor)
            let answerdDict = Dictionary(
                answers.map { ( $0.quewstionID, $0.selectedIndex ) },
                uniquingKeysWith: { first, _ in first}
            )
            
            // 답변하지 않은 질문들 필터링
            let availableQuestions = Question.allQuestions.filter { !answerdDict.keys.contains($0.id) }
            
            // 답변하지 않은 질문들 중에서 7개 랜덤 선택
            selectedRandomQuestion = Array(availableQuestions.shuffled().prefix(7))
 
        } catch {
            selectedRandomQuestion = Array(Question.allQuestions.shuffled().prefix(7))
        }
    }
    
    
    // 답변 선택 및 저장
    func selectAnswer(index: Int) {
        guard let currentQuestion = currentQuestion else { return }
        
        // 딕셔너리에 답변 저장
        answerDictionary[currentQuestion.id] = index
        
        // SwiftData에 답변 저장
        let answer = RunnerAnswer(
            id: UUID(),
            quewstionID: currentQuestion.id,
            selectedIndex: index
        )
        modelContext!.insert(answer)
        
        do {
            try modelContext!.save()
        } catch {
            print("Error saving answer: \(error)")
            answerDictionary.removeValue(forKey: currentQuestion.id)
        }
    }
    
    
    // 다음 질문으로 이동
    func moveToNextQuestion() {
        guard currentQuestionIndex < selectedRandomQuestion.count - 1 else { return }
        currentQuestionIndex += 1
    }
    
    
    
    
    
}


extension MazeViewModel: ObservableObject {}
