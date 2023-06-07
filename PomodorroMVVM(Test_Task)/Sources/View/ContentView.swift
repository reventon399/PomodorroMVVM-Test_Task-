//
//  ContentView.swift
//  PomodorroMVVM(Test_Task)
//
//  Created by Алексей Лосев on 06.06.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TimerViewModel()

    var body: some View {
        ZStack {
            selectedButtonColor()

            VStack {
                HStack {
                    Button(action: {
                        viewModel.setTimer(duration: 1500)
                    }) {
                        Text("Pomodoro")
                            .padding()
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(viewModel.selectedButton == .pomodoro ? Color.white : Color.black)
                            .background(viewModel.selectedButton == .pomodoro ? Color.gray : Color.clear)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        viewModel.setTimer(duration: 300)
                    }) {
                        Text("Short Break")
                            .padding()
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(viewModel.selectedButton == .shortBreak ? Color.white : Color.black)
                            .background(viewModel.selectedButton == .shortBreak ? Color.gray : Color.clear)
                            .cornerRadius(10)
                    }
                    Button(action: {
                        viewModel.setTimer(duration: 900)
                    }) {
                        Text("Long Break")
                            .padding()
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(viewModel.selectedButton == .longBreak ? Color.white : Color.black)
                            .background(viewModel.selectedButton == .longBreak ? Color.gray : Color.clear)
                            .cornerRadius(10)
                    }
                }
                .padding(.bottom, 20)

                Text(viewModel.timeString)
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.white)
                    .padding()

                HStack {
                    switch viewModel.timerState {
                    case .inactive:
                        Button(action: {
                            viewModel.startTimer()
                        }) {
                            Text("Start")
                                .padding()
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    case .active:
                        Button(action: {
                            viewModel.pauseTimer()
                        }) {
                            Text("Pause")
                                .padding()
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    case .paused:
                        Button(action: {
                            viewModel.startTimer()
                        }) {
                            Text("Start")
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }

                    if viewModel.timerState == .active {
                        Button(action: {
                            viewModel.skipToNextBreak()
                        }) {
                            Text("Skip")
                                .padding()
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.setDefaultTimer()
        }
    }

    private func selectedButtonColor() -> some View {
        switch viewModel.selectedButton {
        case .pomodoro:
            return Color.red
        case .shortBreak:
            return Color.green
        case .longBreak:
            return Color.blue
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
