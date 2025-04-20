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
    
    var runner: Runner
    
    // 현재 보여지는 질문의 인덱스
    private(set) var currentQuestionIndex = 0
    private(set) var currentSessionAnswer: [RunnerAnswer] = []
    // 랜덤으로 선택된 7개의 질문 배열
    private(set) var selectedRandomQuestion: [Question] = []
    
    let currentSessionID: UUID
    let timeStamp: Date
    private var preloadedRunners: [Runners] = []
    var matchedRunnerName: String = ""
    
    // 사용자가 선택한 답변들을 저장하는 배열
    // 배열 인덱스로만 비교하는것은 안될거같아서 키값을 사용
    private(set) var answerDictionary: [UUID: Int] = [:]
    
    private(set) var savedAnswers: [RunnerAnswer] = []
    
    private(set) var matchedRunner: MatchedRunner?
    
    
    
    
    
    // 현재 표시되어야 하는 질문
    var currentQuestion: Question? {
            guard !selectedRandomQuestion.isEmpty,
                  currentQuestionIndex < selectedRandomQuestion.count
            else {
                return nil
            }
        return selectedRandomQuestion[currentQuestionIndex]
        }

    
    // 모든 질문에 답변했는지 여부
    var isComplete: Bool {
            guard !selectedRandomQuestion.isEmpty else { return false }
            return currentQuestionIndex == selectedRandomQuestion.count - 1 &&
            answerDictionary.count == selectedRandomQuestion.count
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
        self.currentSessionID = UUID()
        self.timeStamp = Date()
        
        loadPreloadedRunners()
    }
    
    func loadPreloadedRunners() {
        guard let url = Bundle.main.url(forResource: "RunnersData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Error: Could not find or load RunnersData.json")
            return
        }
        do {
            let decoder = JSONDecoder()
            let runnersData = try decoder.decode(MatchedRunnerModel.self, from: data)
            self.preloadedRunners = runnersData.runners
            print(runnersData)
        } catch {
            print("Error loading runners data: \(error)")
        }
    }
    
    func findBestMatch() {
            // 답변 딕셔너리를 기반으로 가장 잘 맞는 러너 찾기
            let sortedRunners = preloadedRunners.sorted { runner1, runner2 in
//                let score1 = calculateMatchScore(runner1)
//                let score2 = calculateMatchScore(runner2)
//                return score1 > score2
                print(runner1)
                print(runner2)
                
                return true
            }
            
//            if let bestMatch = sortedRunners.first {
//                self.matchedRunner = bestMatch
//            }
        }
        
        private func calculateMatchScore(_ runner: MatchedRunner) -> Int {
            var score = 0
            for answer in currentSessionAnswer {
                if let matchingAnswer = runner.answers.first(where: { $0.questionId == answer.quewstionID }) {
                    if matchingAnswer.selectedIndex == answer.selectedIndex {
                        score += 1
                    }
                  }
                }
            return score
            }

    
//    private func findBestMatch() {
//        guard !currentSessionAnswer.isEmpty else { return }
//        
//        var bestMatch: MatchedRunner? = nil
//        var highestScore = 0
//        
//        for var runner in preloadedRunners {
//            var score = 0
//            for answer in currentSessionAnswer {
//                if let preloadedAnswer = runner.answers.first(where: { $0.questionId == answer.quewstionID }) {
//                    if preloadedAnswer.selectedIndex == answer.selectedIndex {
//                        score += 1
//                    }
//                }
//            }
//            runner.matchScore = score
//            if score > highestScore {
//                highestScore = score
//                bestMatch = runner
//            }
//        }
//    matchedRunnerName = bestMatch?.nickname ?? "미등록 사용자"
//    }
    
    
    // 저장된 답변들을 불러오는 메서드
    func loadSavedAnswers() {
        do {
            let descriptor = FetchDescriptor<RunnerAnswer>()
            let answers = try modelContext!.fetch(descriptor)
            savedAnswers = answers
        } catch {
            print("error: \(error)")
        }
    }
    
    
    
    
    // 답변하지 않은 질문들을 로드하고 랜덤하게 7개 선택
//    func loadQuestion() {
//        do {
//            // 기존 답변들 조회
//            let descriptor = FetchDescriptor<RunnerAnswer>()
//            let answers = try modelContext!.fetch(descriptor)
//            let answerdDict = Dictionary(
//                answers.map { ( $0.quewstionID, $0.selectedIndex ) },
//                uniquingKeysWith: { first, _ in first}
//            )
//            
//            // 답변하지 않은 질문들 필터링
//            let availableQuestions = Question.allQuestions.filter { !answerdDict.keys.contains($0.id) }
//            
//            // 답변하지 않은 질문들 중에서 7개 랜덤 선택
//            selectedRandomQuestion = Array(availableQuestions.shuffled().prefix(7))
//            
////            answerDictionary.removeAll()
////            
////            currentQuestionIndex = 0
// 
//        } catch {
//            selectedRandomQuestion = Array(Question.allQuestions.shuffled().prefix(7))
//        }
//    }
    
    func loadQuestion() {
        selectedRandomQuestion = Array(Question.allQuestions.shuffled().prefix(7))
        answerDictionary.removeAll()
        currentQuestionIndex = 0
        currentSessionAnswer.removeAll()
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
            selectedIndex: index,
            sessionID: currentSessionID,
            timestamp: timeStamp
        )
        modelContext!.insert(answer)
        currentSessionAnswer.append(answer)
        
        do {
            try modelContext!.save()
        } catch {
            print("Error saving answer: \(error)")
            answerDictionary.removeValue(forKey: currentQuestion.id)
            currentSessionAnswer.removeLast()
        }
    }
    
    
    // 다음 질문으로 이동
    func moveToNextQuestion() {
        guard currentQuestionIndex < selectedRandomQuestion.count - 1 else { return }
        currentQuestionIndex += 1
    }
    
    
    
    
    struct RunnersDataContainer: Decodable {
        let runners: [MatchedRunner]
    }

    struct MatchedRunner: Identifiable, Decodable {
        let id: String
        let nickname: String
        let answers: [PreloadedAnswer]
        var matchScore: Int = 0
        
        struct PreloadedAnswer: Decodable {
            let questionId: UUID
            let selectedIndex: Int
        }
    }
}


extension MazeViewModel: ObservableObject {}
