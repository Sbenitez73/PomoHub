//
//  PomodoroViewModel.swift
//  Pomohub
//
//  Created by Santiago Benitez on 10/4/23.
//

import SwiftUI

class PomodoroViewModel: NSObject, ObservableObject {
    @Published var progress: CGFloat = 1
    @Published var timerValue: String = "00:00"
    
    @Published var hour: Int = 0
    @Published var minute: Int = 0
    @Published var seconds: Int = 0
    
}
