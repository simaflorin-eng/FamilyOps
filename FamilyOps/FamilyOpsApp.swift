//
//  FamilyOpsApp.swift
//  FamilyOps
//
//  Created by Florin Sima on 14.03.2026.
//

import SwiftUI
import SwiftData

@main
struct FamilyOpsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Child.self, FamilyTask.self])
    }
}
