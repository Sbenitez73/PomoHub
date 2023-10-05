//
//  PomohubApp.swift
//  Pomohub
//
//  Created by Santiago Benitez on 10/3/23.
//

import SwiftUI

@main
struct PomohubApp: App {
    @StateObject var pomodoroModel: PomodoroViewModel = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pomodoroModel)
        }
    }
}
