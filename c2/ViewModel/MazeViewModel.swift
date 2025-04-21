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
        } catch {
            print("Error loading runners data: \(error)")
        }
    }
    
    //전체 러너들을 불러와서 계산을 시킴
    func findBestMatch() -> String {
        var answerArr:[Int] = []
        for runner in preloadedRunners {
            let score = calculateMatchScore(runner)
            answerArr.append(score)
        }
        guard
            let max = answerArr.max()
        else { return "" }
        
        let index = answerArr.firstIndex(of: max)!
        //[0, 5, 3, 5 ....... 6, 7]
        //[광로, 그린.... 카야]
        return preloadedRunners[index].nickname
        
    }
    
    //내가 답변한 7개의 질문 + 러너들의 7개의 질문
    //id가 맞지 않는 오류가 이씀 -> 해결: 0번부터 6번까지 순회후 맞는 질문 아이디 찾고 + 답변까지 같으면 score+ = 1
    private func calculateMatchScore(_ runner: Runners) -> Int {
        var score = 0
        var index = 0
        for answer in currentSessionAnswer {
            let answer1 = answer.questionText
            for i in 0...6 {
                //아이디 같음?
                if answer1 == runner.answers[i].questionId {
                    // 답변 같음?
                    if answer.selectedIndex == runner.answers[index].selectedIndex {
                        score += 1
                    }
                }
            }
            index += 1
            if index == 7 {
                break
            }
        }
        return score
    }
    
    
//    func loadSavedAnswers() {
//        do {
//            let descriptor = FetchDescriptor<RunnerAnswer>(
//                sortBy: [SortDescriptor(\.timestamp, order: .forward)]
//            )
//            let answers = try modelContext!.fetch(descriptor)
//            savedAnswers = answers
//        } catch {
//            print("error: \(error)")
//        }
//    }
//    
    
    
    
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
        //아래의 theID는 필요없음
        guard
            let theID = Question.idByText[currentQuestion.text]
        else { return }
        
        //이게 진짜 비교값
        guard
            let questionId = Questions.idByText[currentQuestion.text]
                else { return }
        answerDictionary[currentQuestion.id] = index
        
        let selectedAnswer = currentQuestion.answers[index]
        let answerText = selectedAnswer.text
        let answerEmoji = selectedAnswer.emoji
//        Question.allQuestions[
        // SwiftData에 답변 저장
        let answer = RunnerAnswer(
            id: UUID(),
            quewstionID: theID,
            selectedIndex: index,
            sessionID: currentSessionID,
            timestamp: timeStamp,
            questionText: questionId,
            selectedText: answerText,
            selectedEmoji: answerEmoji
            
        )
        modelContext!.insert(answer)
        currentSessionAnswer.append(answer)
        
        do {
            try modelContext!.save()
            loadSavedAnswers() // 저장후 불러오는 리스트 ?
        } catch {
            print("Error saving answer: \(error)")
            answerDictionary.removeValue(forKey: currentQuestion.id)
            currentSessionAnswer.removeLast()
        }
    }
    
    // 저장된 답변들을 불러오는 메서드
    func loadSavedAnswers() {
        do {
            guard let context = modelContext else {
                print("modelContext is nil")
                return
            }
            
            var descriptor = FetchDescriptor<RunnerAnswer>(
                sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
            )
            descriptor.fetchLimit = 21
            
            let answers = try context.fetch(descriptor)
            savedAnswers = answers.reversed()
            
        } catch {
            print("error \(error)")
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
