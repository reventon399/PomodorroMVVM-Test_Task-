//
//  TimerViewModel.swift
//  PomodorroMVVM(Test_Task)
//
//  Created by Алексей Лосев on 06.06.2023.
//
import SwiftUI
import Foundation


enum TimerState {
    case inactive
    case active
    case paused
}

enum TimerButton: Int {
    case pomodoro = 1500
    case shortBreak = 300
    case longBreak = 900
}

final class TimerViewModel: ObservableObject {
    
    @Published var timeRemaining = 0
    
    private var timer = Timer()
    
    var timerState: TimerState = .inactive
    var selectedButton: TimerButton = .pomodoro
    
    var timeString: String {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func setTimer(duration: Int) {
        timeRemaining = duration
        stopTimer()
        selectedButton = TimerButton(rawValue: duration) ?? .pomodoro
    }
    
    func stopTimer() {
        timer.invalidate()
        timerState = .inactive
    }
    
    func toggleTimer() {
        switch timerState {
        case .inactive:
            startTimer()
        case .active:
            pauseTimer()
        case .paused:
            resumeTimer()
        }
        
        if timerState == .inactive {
            timeRemaining = 0
        }
    }
    
    func startTimer() {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            timerState = .active
        }
    }
    
    func setDefaultTimer() {
        setTimer(duration: 1500)
    }
    
    func pauseTimer() {
        timer.invalidate()
        timerState = .paused
    }
    
    private func resumeTimer() {
        startTimer()
    }
    
    @objc
    private func updateTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timer.invalidate()
            if timeRemaining == 0 {
                if timer.userInfo == nil {
                    setTimer(duration: 300)
                } else if timer.userInfo as? Int == 300 {
                    setTimer(duration: 900)
                }
            }
        }
    }
    
    private func resetTimer() {
        timer.invalidate()
        timeRemaining = 0
        timerState = .inactive
    }
    
    func skipToNextBreak() {
        timer.invalidate()
        if timeRemaining == 0 {
            if selectedButton == .pomodoro {
                setTimer(duration: 300)
            } else if selectedButton == .shortBreak {
                setTimer(duration: 900)
            }
        }
    }
}

