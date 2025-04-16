//
//  Question.swift
//  c2
//
//  Created by 조재훈 on 4/15/25.
//

import Foundation


struct Question: Identifiable {
    let id = UUID()
    let text: String
    let answers: [Answers]
    
    struct Answers {
        let text: String
        let emoji: String
    }
}

extension Question {
    static let allQuestions = [
        Question(text: "아카데미 n주차에 들어선 지금! 당신은 어떤 사람인가요?",
                 answers: [
                    Answers(text: "나는 세션 전, 운동도 하고 개인 공부도 하고 세션 가야지~!", emoji: "💪"),
                    Answers(text: "나는 세션 전까지 자다가 바로 세션 가야지~!", emoji: "🛌")
                 ]),
        Question(text: "기다리고 기다리던 5월 연휴 첫날! 당신은 무엇을 하며 시간을 보낼 건가요?",
                 answers: [
                    Answers(text: "밖에 나가 놀아야지!", emoji: "🎡"),
                    Answers(text: "집이 최고... 집콕", emoji: "🏠")
                 ]),
        Question(text: "급한 고민이 생겨 친구와 연락하는 당신! 어떤 게 더 편한가요?",
                 answers: [
                    Answers(text: "전화", emoji: "📞"),
                    Answers(text: "문자", emoji: "💬")
                 ]),
        Question(text: "오랜만에 만난 중학교 동창과의 약속을 잡는 당신! 어떤 곳에서 약속을 잡을건가요?",
                 answers: [
                    Answers(text: "카페", emoji: "☕️"),
                    Answers(text: "술집", emoji: "🍺")
                 ]),
        Question(text: "아카데미 수료 후, 어떤 곳으로 여행을 떠나고 싶으신가요?",
                 answers: [
                    Answers(text: "화려한 대도시 여행", emoji: "🏙️"),
                    Answers(text: "고즈넉한 자연 속 여행", emoji: "🍀")
                 ]),
        Question(text: "당신이 현재로 다시 돌아올 수 있는 시간 여행을 떠난다면?",
                 answers: [
                    Answers(text: "과거로", emoji: "🔙"),
                    Answers(text: "미래로", emoji: "🔜")
                 ]),
        Question(text: "당신은 어떤 사람인가요?",
                 answers: [
                    Answers(text: "혼자 충전하는 시간이 더 중요한 편", emoji: "🔋"),
                    Answers(text: "에너지를 사람들과 나누는 편", emoji: "🤩")
                 ]),
        Question(text: "당신은 어떤 사람인가요?",
                 answers: [
                    Answers(text: "미리 계획을 세우고, 그 계획대로 일이 진행되는 걸 선호해요!", emoji: "🗺️"),
                    Answers(text: "상황에 맞게 유연하게 대처하고, 즉흥적인 선택도 즐기는 편이에요!", emoji: "🕺")
                 ]),
        Question(text: "새로운 사람을 만날 때 당신은?",
                 answers: [
                    Answers(text: "간택하는 사람", emoji: "😽"),
                    Answers(text: "간택을 기다리는 사람", emoji: "😺")
                 ]),
        Question(text: "어떤 것이 더 좋나요?",
                 answers: [
                    Answers(text: "솔직히 조언 해주기", emoji: "😉"),
                    Answers(text: "친구가 언제나 내 편 들어주기", emoji: "☺️")
                 ]),
        Question(text: "어떤게 더 좋나요?",
                 answers: [
                    Answers(text: "노력해서 얻은 성취", emoji: "🔥"),
                    Answers(text: "예상치 못한 행운", emoji: "🍀")
                 ]),
        Question(text: "열심히 공부하는 당신! 어디서 공부하고 싶나요?",
                 answers: [
                    Answers(text: "도서관 카페 등의 공공장소", emoji: "🏙️"),
                    Answers(text: "집 또는 나만이 혼자 있을 수 있는 공간", emoji: "🚪")
                 ]),
        Question(text: "팀플을 하는 당신, 어떤 편인가요?",
                 answers: [
                    Answers(text: "팀 내 즉흥 브레인스토밍", emoji: "🧠"),
                    Answers(text: "혼자 생각 정리 후 제안", emoji: "🧐")
                 ]),
        Question(text: "누군가와 싸웠을 때 당신은?",
                 answers: [
                    Answers(text: "바로 바로 푼다", emoji: "✋🏻"),
                    Answers(text: "일단 회피한다", emoji: "🙈")
                 ]),
        Question(text: "당신은 어떤 사람인가요?",
                 answers: [
                    Answers(text: "결과 중심", emoji: "👍"),
                    Answers(text: "과정 중심", emoji: "➡️")
                 ]),
        Question(text: "어떤 일을 할 때 당신은?",
                 answers: [
                    Answers(text: "일단 질러! 고민하지 않고 바로 시도하는 편", emoji: "😜"),
                    Answers(text: "생각 먼저.. 긴 고민 후 시도해도 늦지 않아", emoji: "🫠")
                 ]),
        Question(text: "취업과 창업 중 하나를 선택하자면?",
                 answers: [
                    Answers(text: "창업", emoji: "💡"),
                    Answers(text: "취업", emoji: "💼")
                 ]),
        Question(text: "남녀 사이에 친구가?",
                 answers: [
                    Answers(text: "있다", emoji: "‼️"),
                    Answers(text: "없다", emoji: "❌")
                 ]),
        Question(text: "연애할 때 당신은?",
                 answers: [
                    Answers(text: "2주에 한 번 만나기", emoji: "✌🏻"),
                    Answers(text: "매일 매일 만나기", emoji: "😘")
                 ]),
        Question(text: "라이프저니! 러너들에게 서로 공유하실 수 있나요?",
                 answers: [
                    Answers(text: "아니요! 공개하지 않고 다른 러너 것도 안 볼래요", emoji: "🙅🏻‍♀️"),
                    Answers(text: "넵! 저도 공개하고 다른 러너 것도 볼래요", emoji: "🙆🏻‍♀️")
                 ]),
        Question(text: "당신의 유니크 포인트를 알려주세요!",
                 answers: [
                    Answers(text: "아니요! 공개하지 않고 다른 러너 것도 안 볼래요", emoji: "🙅🏻‍♀️"),
                    Answers(text: "넵! 저도 공개하고 다른 러너 것도 볼래요", emoji: "🙆🏻‍♀️")
                 ]),
        
    ]
}
