//
//  AnswerService.swift
//  c2
//
//  Created by 조재훈 on 4/15/25.
//

import Foundation
import SwiftData


import SwiftData

@Observable
@MainActor


final class AnswerService {
    //싱글톤 인스턴스
    static let shared = AnswerService()
    private init() {}
    
    func saveAnswer(
        questionID: UUID,
        runnerNickname: String,
        answerIndex: Int,
        modelContext: ModelContext
    ) {
        //기존 답변 찾기
        let newData = Answer(id: questionID, questionID: questionID, runnerNickname: runnerNickname, selectedAnswerIndex: 0)
        modelContext.insert(newData)
        print("\(newData) saved")
    }
    
    func read(modelContext: ModelContext) -> [Answer] {
        do {
            let model = try modelContext.fetch(FetchDescriptor<Answer>())

            return model
        } catch {
            print(error)
            return []
        }
    }
    
    
    // SwiftData 컨테이너
    //    private var modelContainer: ModelContainer
    //    private var modelContext: ModelContext
    //
    //    private init() {
    //        let container: ModelContainer
    //        let context: ModelContext
    //        // SwfitData 설정
    //        do {
    //            let schema = Schema([Answer.self])
    //            let modelConfiguration = ModelConfiguration(schema: schema)
    //            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
    //            context = container.mainContext
    //
    //        } catch {
    //            fatalError("Could not initialize AnswerService: \(error)")
    //        }
    //        self.modelContainer = container
    //        self.modelContext = context
    //
    //        setupInitialDataIfNeeded()
    //    }
    
    // 답변 저장/업데이트
    //    func saveAnswer(questionID: UUID, runnerNickname: String, answerIndex: Int) {
    //        //기존 답변 찾기
    //        let descriptor = FetchDescriptor<Answer>(
    //            predicate: #Predicate<Answer> { answer in
    //                answer.questionID == questionID &&
    //                answer.runnerNickname == runnerNickname
    //            }
    //        )
    //
    //        do {
    //            // 기존 답변이 있는지 확인
    //            let existingAnswers = try modelContext.fetch(descriptor)
    //
    //            if let existingAnswer = existingAnswers.first {
    //                //기존 답변 업데이트
    //                existingAnswer.selectedAnswerIndex = answerIndex
    //            } else {
    //                // 새 답변 생성
    //                let newAnswer = Answer(
    //                    id: UUID(), questionID: questionID,
    //                    runnerNickname: runnerNickname,
    //                    selectedAnswerIndex: answerIndex
    //                )
    //
    //                modelContext.insert(newAnswer)
    //            }
    //            // 변경사항 저장
    //            try modelContext.save()
    //        } catch {
    //            print("Error saving answer: \(error)")
    //        }
    //    }
    //
    //
    //
    //    // 특정 질문에 대한 답변들 가져오기
    //    func getAnswers(for questionID: UUID) -> [Answer] {
    //        let descriptor = FetchDescriptor<Answer>(
    //            predicate: #Predicate<Answer> { answer in
    //                answer.questionID == questionID
    //            }
    //        )
    //        do {
    //            return try modelContext.fetch(descriptor)
    //        } catch {
    //            print("Error fetching answers: \(error)")
    //            return []
    //        }
    //    }
    //
    //
    //
    //    // 통계 계산
    //    func getStatistics(for questionID: UUID) -> [Int] {
    //        let answers = getAnswers(for: questionID)
    //        var stats = [0, 0]
    //
    //        answers.forEach { answer in
    //            stats[answer.selectedAnswerIndex] += 1
    //        }
    //
    //        return stats
    //    }
    //
    //
    //
    //
    //
    //
    //
    //    // 초기 데이터 설정
    //    private func setupInitialDataIfNeeded() {
    //        // 기존 데이터가 있는지 확인
    //        let descriptor = FetchDescriptor<Answer>()
    //
    //        do {
    //            let count = try modelContext.fetch(descriptor).count
    //            if count == 0 {
    //                // 초기 데이터 생성
    //                let initialData: [(String, UUID, Int)] = [
    //                    ("presence", Question.allQuestions[0].id, 0),
    //                    ("jooni", Question.allQuestions[0].id, 1),
    //                    ("herry", Question.allQuestions[0].id, 0)
    //                ]
    //                // 초기 데이터 저장
    //                for (nickname, questionID, answer) in initialData {
    //                    let answer = Answer(
    //                        id: UUID(), questionID: questionID,
    //                        runnerNickname: nickname,
    //                        selectedAnswerIndex: answer
    //                        )
    //                    modelContext.insert(answer)
    //                }
    //
    //                try modelContext.save()
    //            }
    //        } catch {
    //            print("Error setting up initial dta: \(error)")
    //        }
    //    }
    //}
    //
    //
}
