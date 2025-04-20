




import Foundation


struct MatchedRunner: Codable, Identifiable {
    let id: String
    let nickname: String
    let answers: [PreloadedAnswer]
    var matchScore: Int = 0
    
    struct PreloadedAnswer: Codable {
        let questionId: UUID
        let selectedIndex: Int
    }
}

struct RunnersDataContainer: Codable {
    let runners: [MatchedRunner]
}


//MARK: 실행되는 모델
struct MatchedRunnerModel: Codable {
    let runners: [Runners]
}

struct Runners: Codable {
    let id: String
    let nickname: String
    let answers: [Answer]
    
    struct Answer: Codable {
        let questionId: String
        let selectedIndex: Int
    }
}
