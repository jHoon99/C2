//
//  Question.swift
//  c2
//
//  Created by 조재훈 on 4/15/25.
//

import Foundation

struct Question: Identifiable {
    let id: UUID
    let text: String
    let answers: [Answer]
    
    struct Answer {
        let text: String
        let emoji: String
    }
    
    // 모든 질문들을 static 상수로 정의
    static let allQuestions: [Question] = [
        Question(
            id: UUID(uuidString: "A1B2C3D4-E5F6-47G8-H9I0-J1K2L3M4N5O6") ?? UUID(),
            text: "아카데미 3주차에 들어선 지금! 당신은 어떤 사람인가요?",
            answers: [
                Answer(text: "나는 세션 전, 운동도 하고 개인 공부도 하고 세션 가야지", emoji: "💪🏻"),
                Answer(text: "나는 세션 전까지 자다가 바로 세션 가야지", emoji: "🛌")
            ]
        ),
        Question(
            id: UUID(uuidString: "B2C3D4E5-F6G7-48H9-I0J1-K2L3M4N5O6P7") ?? UUID(),
            text: "기다리고 기다리던 5월 연휴 첫날! 당신은 무엇을 하며 시간을 보낼 건가요?",
            answers: [
                Answer(text: "밖에 나가 놀아야지", emoji: "🎡"),
                Answer(text: "집이 최고 .. 집콕", emoji: "🏠")
            ]
        ),
        Question(
            id: UUID(uuidString: "C3D4E5F6-G7H8-49I0-J1K2-L3M4N5O6P7Q8") ?? UUID(),
            text: "급한 고민이 생겨 친구와 연락하는 당신! 어떤 게 더 편한가요?",
            answers: [
                Answer(text: "전화", emoji: "📞"),
                Answer(text: "문자 메세지", emoji: "💬")
            ]
        ),
        Question(
            id: UUID(uuidString: "D4E5F6G7-H8I9-50J1-K2L3-M4N5O6P7Q8R9") ?? UUID(),
            text: "오랜만에 만난 중학교 동창과의 약속을 잡는 당신! 어떤 곳에서 약속을 잡을건가요?",
            answers: [
                Answer(text: "카페", emoji: "☕️"),
                Answer(text: "술집", emoji: "🍺")
            ]
        ),
        Question(
            id: UUID(uuidString: "E5F6G7H8-I9J0-51K2-L3M4-N5O6P7Q8R9S0") ?? UUID(),
            text: "아카데미 수료 후, 어떤 곳으로 여행을 떠나고 싶으신가요?",
            answers: [
                Answer(text: "고즈넉한 자연 속 여행", emoji: "🌿"),
                Answer(text: "화려한 대도시 여행", emoji: "🏙️")
            ]
        ),
        Question(
            id: UUID(uuidString: "F6G7H8I9-J0K1-52L3-M4N5-O6P7Q8R9S0T1") ?? UUID(),
            text: "당신이 현재로 다시 돌아올 수 있는 시간 여행을 떠난다면?",
            answers: [
                Answer(text: "과거로", emoji: "🔙"),
                Answer(text: "미래로", emoji: "🔜")
            ]
        ),
        Question(
            id: UUID(uuidString: "G7H8I9J0-K1L2-53M4-N5O6-P7Q8R9S0T1U2") ?? UUID(),
            text: "당신은 어떤 사람인가요?",
            answers: [
                Answer(text: "혼자 충전하는 시간이 더 중요한 편", emoji: "🔋"),
                Answer(text: "에너지를 사람들과 나누는 편", emoji: "🤩")
            ]
        ),
        Question(
            id: UUID(uuidString: "H8I9J0K1-L2M3-54N5-O6P7-Q8R9S0T1U2V3") ?? UUID(),
            text: "당신은 어떤 사람인가요??",
            answers: [
                Answer(text: "미리 계획을 세우고, 그 계획대로 일이 진행되는 걸 선호해요!", emoji: "🗺️"),
                Answer(text: "상황에 맞게 유연하게 대처하고, 즉흥적인 선택도 즐기는 편이에요!", emoji: "🕺")
            ]
        ),
        Question(
            id: UUID(uuidString: "I9J0K1L2-M3N4-55O5-P6Q7-R8S9T0U1V2W3") ?? UUID(),
            text: "새로운 사람을 만날 때 당신은?",
            answers: [
                Answer(text: "간택하는 사람", emoji: "😽"),
                Answer(text: "간택을 기다리는 사람", emoji: "😺")
            ]
        ),
        Question(
            id: UUID(uuidString: "J0K1L2M3-N4O5-56P6-Q7R8-S9T0U1V2W3X4") ?? UUID(),
            text: "어떤 것이 더 좋나요?",
            answers: [
                Answer(text: "솔직히 조언 해주기", emoji: "😉"),
                Answer(text: "친구가 언제나 내 편 들어주기", emoji: "☺️")
            ]
        ),
        Question(
            id: UUID(uuidString: "K1L2M3N4-O5P6-57Q7-R8S9-T0U1V2W3X4Y5") ?? UUID(),
            text: "어떤게 더 좋나요?",
            answers: [
                Answer(text: "노력해서 얻은 성취", emoji: "🔥"),
                Answer(text: "예상치 못한 행운", emoji: "🍀")
            ]
        ),
        Question(
            id: UUID(uuidString: "L2M3N4O5-P6Q7-58R8-S9T0-U1V2W3X4Y5Z6") ?? UUID(),
            text: "열심히 공부하는 당신! 어디서 공부하고 싶나요?",
            answers: [
                Answer(text: "도서관 카페 등의 공공장소", emoji: "🏙️"),
                Answer(text: "집 또는 나만이 혼자 있을 수 있는 공간", emoji: "🚪")
            ]
        ),
        Question(
            id: UUID(uuidString: "M3N4O5P6-Q7R8-59S9-T0U1-V2W3X4Y5Z6A7") ?? UUID(),
            text: "팀플을 하는 당신, 어떤 편인가요?",
            answers: [
                Answer(text: "팀 내 즉흥 브레인스토밍", emoji: "🧠"),
                Answer(text: "혼자 생각 정리 후 제안", emoji: "🧐")
            ]
        ),
        Question(
            id: UUID(uuidString: "N4O5P6Q7-R8S9-60T0-U1V2-W3X4Y5Z6A7B8") ?? UUID(),
            text: "누군가와 싸웠을 때 당신은?",
            answers: [
                Answer(text: "바로 바로 푼다", emoji: "✋🏻"),
                Answer(text: "일단 회피한다", emoji: "🙈")
            ]
        ),
        Question(
            id: UUID(uuidString: "O5P6Q7R8-S9T0-61U1-V2W3-X4Y5Z6A7B8C9") ?? UUID(),
            text: "당신은 어떤 중심 인가요?",
            answers: [
                Answer(text: "결과 중심", emoji: "👍"),
                Answer(text: "과정 중심", emoji: "➡️")
            ]
        ),
        Question(
            id: UUID(uuidString: "P6Q7R8S9-T0U1-62V2-W3X4-Y5Z6A7B8C9D0") ?? UUID(),
            text: "어떤 일을 할 때 당신은?",
            answers: [
                Answer(text: "일단 질러! 고민하지 않고 바로 시도하는 편", emoji: "😜"),
                Answer(text: "생각 먼저.. 긴 고민 후 시도해도 늦지 않아", emoji: "🫠")
            ]
        ),
        Question(
            id: UUID(uuidString: "Q7R8S9T0-U1V2-63W3-X4Y5-Z6A7B8C9D0E1") ?? UUID(),
            text: "취업과 창업 중 하나를 선택하자면?",
            answers: [
                Answer(text: "창업", emoji: "💡"),
                Answer(text: "취업", emoji: "💼")
            ]
        ),
        Question(
            id: UUID(uuidString: "R8S9T0U1-V2W3-64X4-Y5Z6-A7B8C9D0E1F2") ?? UUID(),
            text: "남녀 사이에 친구가?",
            answers: [
                Answer(text: "있다", emoji: "‼️"),
                Answer(text: "없다", emoji: "❌")
            ]
        ),
        Question(
            id: UUID(uuidString: "S9T0U1V2-W3X4-65Y5-Z6A7-B8C9D0E1F2G3") ?? UUID(),
            text: "연애할 때 당신은?",
            answers: [
                Answer(text: "2주에 한 번 만나기", emoji: "✌🏻"),
                Answer(text: "매일 매일 만나기", emoji: "😘")
            ]
        ),
        Question(
            id: UUID(uuidString: "T0U1V2W3-X4Y5-66Z6-A7B8-C9D0E1F2G3H4") ?? UUID(),
            text: "라이프저니! 러너들에게 서로 공유하실 수 있나요?",
            answers: [
                Answer(text: "아니요! 공개하지 않고 다른 러너 것도 안 볼래요", emoji: "🙅🏻‍♀️"),
                Answer(text: "넵! 저도 공개하고 다른 러너 것도 볼래요", emoji: "🙆🏻‍♀️")
            ]
        )
    ]
}
extension Question {
    static let idByText: [String: UUID] = {
        Dictionary(
            uniqueKeysWithValues: allQuestions.map { ($0.text, $0.id) }
        )
    }()
}

