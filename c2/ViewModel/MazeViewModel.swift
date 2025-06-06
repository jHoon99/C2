//
//  MazeViewModel.swift
//  c2
//
//  Created by 조재훈 on 4/16/25.
//

import Foundation
import SwiftData


@Observable

final class MazeViewModel: ObservableObject {
    
    // SwiftData 저장
    private let modelContext: ModelContext?
    var runner: Runner
    
    init(
        runner: Runner,
        modelContext: ModelContext?
    ) {
        self.runner = runner
        self.modelContext = modelContext
        self.currentSessionID = UUID()
        self.timeStamp = Date()
        
    }
    
    
    // 현재 보여지는 질문의 인덱스
    private(set) var currentQuestionIndex = 0
    // 랜덤으로 선택된 7개의 질문 배열
    private(set) var selectedRandomQuestion: [Question] = []
    
    
    var currentSessionID: UUID
    var timeStamp: Date
    private(set) var currentSessionAnswer: [RunnerAnswer] = []
    
    
    private var preloadedRunners: [Runners] = []
    
    
    // 사용자가 선택한 답변들을 저장하는 배열
    // 배열 인덱스로만 비교하는것은 안될거같아서 키값을 사용
    
    private(set) var savedAnswers: [RunnerAnswer] = []
    private(set) var sessionGroupes: [SessionGroup] = []
    private(set) var answerDictionary: [UUID: Int] = [:]
    
    

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
    
    // 다음 질문으로 이동
    func moveToNextQuestion() {
        guard currentQuestionIndex < selectedRandomQuestion.count - 1 else { return }
        currentQuestionIndex += 1
    }


    // json데이터 디코딩
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
    
    //전체 러너들(loadPreloadedRunners)을 불러와서 계산을 시킴
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
    
    
    // mazeView에 7개 랜덤질문 뿌리기
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
        modelContext?.insert(answer)
        currentSessionAnswer.append(answer)
         
        
        do {
            
            try modelContext?.save()
            if currentSessionAnswer.count == 7 {
                currentSessionID = UUID()
                timeStamp = Date()
                loadSessionGroups()
            }
            
           
        } catch {
            print("Error saving answer: \(error)")
            answerDictionary.removeValue(forKey: currentQuestion.id)
            currentSessionAnswer.removeLast()
        }
    }
    
    
    
    
    func loadSessionGroups() {
        guard let context = modelContext else { return }
        
        do {
            let descriptor = FetchDescriptor<RunnerAnswer>(
                sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
            )
            let allAnswers = try context.fetch(descriptor)
            
            // 세션 그룹화 (sessionID 별로)
            let grouped = Dictionary(grouping: allAnswers) { $0.sessionID }
            
            // 7개 단위로 필터
            sessionGroupes = grouped.compactMap { key, value in
                guard value.count == 7 else { return nil }
                return SessionGroup(
                    id: key,
                    timestamp: value.first?.timestamp ?? Date(),
                    answers: value.sorted { $0.timestamp < $1.timestamp}
                )
            }
            .sorted { $0.timestamp > $1.timestamp } // 최신 세션 정렬
            
            
        } catch {
            print("Error loading session groups: \(error)")
        }
        
        
    }
}


extension MazeViewModel {
    struct SessionGroup: Identifiable {
        var id: UUID
        var timestamp: Date
        var answers: [RunnerAnswer]
    }
}



