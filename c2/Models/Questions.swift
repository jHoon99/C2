//
//  Questions.swift
//  c2
//
//  Created by 조재훈 on 4/20/25.
//

struct Questions: Identifiable {
    let id: String
    let text: String
    let answers: [Answer]
    
    struct Answer {
        let text: String
        let emoji: String
    }
    
    // 모든 질문들을 static 상수로 정의
    static let allQuestions: [Questions] = [
        Questions(
            id: "A1B2C3D4-E5F6-47G8-H9I0-J1K2L3M4N5O6",
            text: "아카데미 3주차에 들어선 지금! 당신은 어떤 사람인가요?",
            answers: [
                Answer(text: "나는 세션 전, 운동도 하고 개인 공부도 하고 세션 가야지", emoji: "💪🏻"),
                Answer(text: "나는 세션 전까지 자다가 바로 세션 가야지", emoji: "🛌")
            ]
        ),
        Questions(
            id: "B2C3D4E5-F6G7-48H9-I0J1-K2L3M4N5O6P7",
            text: "기다리고 기다리던 5월 연휴 첫날! 당신은 무엇을 하며 시간을 보낼 건가요?",
            answers: [
                Answer(text: "밖에 나가 놀아야지", emoji: "🎡"),
                Answer(text: "집이 최고 .. 집콕", emoji: "🏠")
            ]
        ),
        Questions(
            id: "C3D4E5F6-G7H8-49I0-J1K2-L3M4N5O6P7Q8",
            text: "급한 고민이 생겨 친구와 연락하는 당신! 어떤 게 더 편한가요?",
            answers: [
                Answer(text: "전화", emoji: "📞"),
                Answer(text: "문자 메세지", emoji: "💬")
            ]
        ),
        Questions(
            id: "D4E5F6G7-H8I9-50J1-K2L3-M4N5O6P7Q8R9",
            text: "오랜만에 만난 중학교 동창과의 약속을 잡는 당신! 어떤 곳에서 약속을 잡을건가요?",
            answers: [
                Answer(text: "카페", emoji: "☕️"),
                Answer(text: "술집", emoji: "🍺")
            ]
        ),
        Questions(
            id: "E5F6G7H8-I9J0-51K2-L3M4-N5O6P7Q8R9S0",
            text: "아카데미 수료 후, 어떤 곳으로 여행을 떠나고 싶으신가요?",
            answers: [
                Answer(text: "고즈넉한 자연 속 여행", emoji: "🌿"),
                Answer(text: "화려한 대도시 여행", emoji: "🏙️")
            ]
        ),
        Questions(
            id: "F6G7H8I9-J0K1-52L3-M4N5-O6P7Q8R9S0T1",
            text: "당신이 현재로 다시 돌아올 수 있는 시간 여행을 떠난다면?",
            answers: [
                Answer(text: "과거로", emoji: "🔙"),
                Answer(text: "미래로", emoji: "🔜")
            ]
        ),
        Questions(
            id: "G7H8I9J0-K1L2-53M4-N5O6-P7Q8R9S0T1U2",
            text: "당신은 어떤 사람인가요?",
            answers: [
                Answer(text: "혼자 충전하는 시간이 더 중요한 편", emoji: "🔋"),
                Answer(text: "에너지를 사람들과 나누는 편", emoji: "🤩")
            ]
        ),
//        Question(
//            id: UUID(uuidString: "H8I9J0K1-L2M3-54N5-O6P7-Q8R9S0T1U2V3") ?? UUID(),
//            text: "당신은 어떤 사람인가요?",
//            answers: [
//                Answer(text: "미리 계획을 세우고, 그 계획대로 일이 진행되는 걸 선호해요!", emoji: "🗺️"),
//                Answer(text: "상황에 맞게 유연하게 대처하고, 즉흥적인 선택도 즐기는 편이에요!", emoji: "🕺")
//            ]
//        ),
    ]
}
extension Questions {
    static let idByText: [String: String] = {
        Dictionary(
            uniqueKeysWithValues: allQuestions.map { ($0.text, $0.id) }
        )
    }()
}
