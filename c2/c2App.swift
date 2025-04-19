//
//  c2App.swift
//  c2
//
//  Created by 조재훈 on 4/14/25.
//

import SwiftUI
import SwiftData

@main
struct c2App: App {
    var modelContainer: ModelContainer = {
        let schema = Schema([
            RunnerAnswer.self
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("\(error)")
            }
    }()
    
    var body: some Scene {
        WindowGroup {
                ContentView()
        }
        .modelContainer(modelContainer)
    }
}


