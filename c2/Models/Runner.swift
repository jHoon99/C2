//
//  Runeer.swift
//  c2
//
//  Created by 조재훈 on 4/14/25.
//

import Foundation
import SwiftUICore



struct Runner: Identifiable {
    let id = UUID()
    let nickname: String
}

extension Runner {
    
    static func isNicknameValid(_ nickname: String) -> Bool {
        let inputNickname = nickname
        return runnerNickname.contains(inputNickname.lowercased())
    }
    
    static let runnerNickname = [
        "presence", "jooni", "herry", "jerry", "jeje", "soop", "paduck", "cerin", "ian", "julianne",
        "luke", "green", "rohd", "weaver", "alex", "jina", "monica", "kinder", "riel", "lina", "hevyn",
        "yuha", "powel", "rama", "romak", "leon", "theo", "ari", "skyler", "miru", "kaia", "il", "taki",
        "daniely", "seo", "peppr", "isa", "mary", "one", "isla", "ivy", "yoshi", "pray", "gyeong", "singsing",
        "rundo", "lemon", "jung", "joid", "libby", "root", "hong", "loa", "erin", "jeong", "tether", "coulson",
        "emma", "my", "luka", "bob", "zigu", "enoch", "lucas", "paran", "eifer", "karyn", "hari", "bota",
        "eddey", "velko", "nayl", "minbol", "gil", "jenna", "sandeul", "zani", "anne", "dewy", "oliver",
        "nell", "kadan", "mumin", "paidion", "sally", "excellenty", "jack", "sena", "dean", "bear", "nika",
        "yan", "nike", "viera", "evan", "nyx", "hama", "demian", "yeony", "onething", "cheshire", "pherd",
        "may", "jenki", "echo", "dodin", "jin", "berry", "kwangro", "joy", "wish", "baba", "air", "frank",
        "hyun", "mingky", "ria", "woody", "glowny", "jun", "mini", "ted", "jomi", "wade", "bin", "sky", "j",
        "ella", "ken", "ssol", "finn", "steve", "jam", "leo", "cherry", "gabi", "ethan", "jaeryong", "taeni",
        "way", "sera", "kon", "zhen", "min", "elphie", "noah", "fine", "yoon", "moo", "judyj", "simi", "murphy",
        "kave", "junia", "ell", "go", "snow", "angie", "brandnew", "yuu", "martin", "three", "elena", "noter",
        "elian", "sana", "ito", "gus", "chloe", "gigi", "wendy", "hidy", "wonjun", "henry", "kirby", "avery",
        "happyjay", "heggy", "mosae", "jacob", "gommin", "nathan", "daisy", "dora", "lumi", "leeo", "saya",
        "sup", "mk", "jason", "judy", "jiku", "friday", "howard", "gwen", "soo", "sunny", "summer", "sungp",
        "young", "lingo", "hailey", "isaac", "jinny", "scarly"
    ]
}


