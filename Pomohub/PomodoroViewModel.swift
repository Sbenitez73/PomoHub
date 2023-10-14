//
//  PomodoroViewModel.swift
//  Pomohub
//
//  Created by Santiago Benitez on 10/4/23.
//

import SwiftUI

class PomodoroViewModel: NSObject, ObservableObject {
    @Published var progress: CGFloat = 1
    @Published var timerValue: String = "25:00"
    
    @Published var isStarted: Bool = false
    @Published var isFinished: Bool = false
    @Published var isPauseTimer: Bool = false
    @Published var addNewTimer: Bool = false
    @Published var showCustomTime: Bool = false
    @Published var isUnallowedStart: Bool = false
    
    @Published var hour: Int = 0
    @Published var minutes: Int = 25
    @Published var seconds: Int = 0
    
    @Published var totalSeconds: Int = 0
    @Published var staticTotalSeconds: Int = 0
    
    
    func startTimer() {
        timerValue = setTimeValue()
        totalSeconds = (hour * 3600) + (minutes * 60) + seconds
        isUnallowedStart = totalSeconds == 0
        
        if !isUnallowedStart {
            withAnimation(.easeInOut(duration: 0.25)){isStarted = true}
            staticTotalSeconds = totalSeconds
            addNewTimer = false
        }
    }
    
    func stopTimer() {
        withAnimation{
            isStarted = false
            hour = 0
            minutes = 25
            seconds = 0
            progress = 1
        }
        
        totalSeconds = 0
        staticTotalSeconds = 0
        timerValue = "00:00"
        isPauseTimer = false
    }
    
    func updateTimer() {
        totalSeconds -= 1
        progress = CGFloat(totalSeconds) / CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress)
        hour = totalSeconds / 3600
        minutes = (totalSeconds / 60) % 60
        seconds = (totalSeconds % 60)
        timerValue = setTimeValue()
        
        if hour == 0 && seconds == 0 && minutes == 0 {
            isStarted = false
            isFinished = true
        }
    }
    
    func setTimeValue() -> String {
        return "\(minutes >= 10 ? "\(minutes)" : "0\(minutes)"):\(seconds >= 10 ? "\(seconds)" : "0\(seconds)")"
    }
}
