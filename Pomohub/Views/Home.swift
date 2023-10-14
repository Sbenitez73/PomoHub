//
//  Home.swift
//  Pomohub
//
//  Created by Santiago Benitez on 10/4/23.
//

import SwiftUI
import AlertToast

struct Home: View {
    @EnvironmentObject var pomodoroModel: PomodoroViewModel
    
    var body: some View {
            
        NavBar(subtitle: "Home")
    
        VStack {
            
            //Clock
            GeometryReader { proxy in
                VStack(spacing:15) {
                    ZStack {
                        Circle()
                        .fill(.white.opacity(0.04))
                        .padding(-40)
                    
                        Circle()
                            .stroke(Color("Secondary"), lineWidth: 5)
                            .blur(radius: 15)
                            .padding(-2)
                        
                        Circle()
                            .fill(Color("Background"))
                        
                        Circle()
                            .trim(from: 0, to: pomodoroModel.progress)
                            .stroke(Color("Secondary").opacity(0.7), lineWidth: 10)
                        
                        
                        GeometryReader{ proxy in
                            let size = proxy.size
                            
                            Circle()
                                .fill(Color("Secondary"))
                                .frame(width: 30, height: 30)
                                .overlay(content: {
                                    Circle()
                                        .fill(.white)
                                        .padding(5)
                                })
                                .frame(width: size.width,
                                       height: size.height,
                                       alignment: .center)
                                .offset(x: size.height / 2)
                                .rotationEffect(.init(degrees: pomodoroModel.progress * 360))

                        }
                        
                        Text(pomodoroModel.setTimeValue())
                            .font(.system(size: 45, weight: .light))
                            .rotationEffect(.init(degrees: 90))
                            .animation(.none, value: pomodoroModel.progress)
                    }
                    .padding(40)
                    .frame(height: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeInOut, value: pomodoroModel.progress)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .onTapGesture( perform: {
                    pomodoroModel.progress = 0.5
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
            if !pomodoroModel.isStarted {
                Button("Custom Time") {
                    withAnimation{
                        pomodoroModel.showCustomTime.toggle()
                    }
                }
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color("Secondary"))
                    .underline()
                    .onTapGesture {
                        pomodoroModel.showCustomTime.toggle()
                    }
            }
            
            //Custom time
            if pomodoroModel.showCustomTime && !pomodoroModel.isStarted  {
                HStack(spacing: 25) {
                    Text("\(pomodoroModel.minutes >= 10 ? "\(pomodoroModel.minutes)" : "0\(pomodoroModel.minutes)")")
                        .font(.system(size: 50 ).bold())
                        .contextMenu{
                            ContextMenuOptions(maxValue: 60, hint: "min", onClick: { value in
                                pomodoroModel.minutes = value
                            })
                        }
                    Text(":")
                        .font(.system(size: 50 ).bold())
                        .foregroundStyle(Color("ThinGray"))
                    Text("\(pomodoroModel.seconds >= 10 ? "\(pomodoroModel.seconds)" : "0\(pomodoroModel.seconds)")")
                        .font(.system(size: 50 ).bold())
                        .contextMenu{
                            ContextMenuOptions(maxValue: 60, hint: "sec", onClick: { value in
                                pomodoroModel.seconds = value
                            })
                        }
                }
                .padding(20)
                .background{
                    Rectangle()
                        .fill(Color("Gray"))
                        .cornerRadius(20)
                        .animation(.easeInOut, value: pomodoroModel.showCustomTime)
                }
                .padding(.bottom, 50)
                .transition(.scale)
                
            }
            
            // Stop and Pause buttons
            if pomodoroModel.isStarted {
                HStack(spacing: 20) {
                    HStack {
                        Button(action: {
                            pomodoroModel.isPauseTimer.toggle()
                        }) {
                            HStack{
                                Image(systemName: !pomodoroModel.isPauseTimer ? "pause" : "play")
                                    .font(.title2.bold())
                                    .foregroundColor(Color("Background"))
                                Text(!pomodoroModel.isPauseTimer ? "Pausa" : "Reanudar")
                                    .font(.system(size: 20).bold())
                                    .tint(Color("Background"))
                            }
                            
                        }
                        .frame(minWidth: 140)
                    }
                    .padding()
                    .background{
                        Rectangle()
                            .fill(Color("Secondary"))
                            .cornerRadius(20)
                    }
                    HStack {
                        Button(action: {
                            pomodoroModel.stopTimer()
                        }) {
                            HStack{
                                Image(systemName: "stop")
                                    .font(.title2.bold())
                                    .foregroundColor(Color("Secondary"))
                                Text("Detener")
                                    .font(.system(size:20).bold())
                                    .tint(Color("Secondary"))
                            }
                            
                        }
                        .frame(minWidth: 140)
                    }
                    .padding()
                    .background{
                        Rectangle()
                            .fill(Color("Background"))
                            .cornerRadius(20)
                            .cornerRadius(20)
                            .overlay{
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("Secondary"), lineWidth: 3)
                            }
                    }
                }
            } else {
                // Start button
                HStack(spacing: 20) {
                    HStack {
                        Button(action: {
                            pomodoroModel.startTimer()
                        }) {
                            Image(systemName: "play")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                                .frame(width: 80, height: 80)
                            
                        }
                    }
                    .background{
                        Circle()
                            .fill(Color("Secondary"))
                    }
                }
            }
        }
        .padding()
        .background{
            Color("Background")
        }
        .onReceive(Timer.publish(every: 1, on: .current, in: .common).autoconnect()) {
            _ in
            if pomodoroModel.isStarted && !pomodoroModel.isPauseTimer {
                pomodoroModel.updateTimer()
            }
        }
        .toast(isPresenting: $pomodoroModel.isUnallowedStart) {
            AlertToast(type: .error(Color("Primary")), title: "El temporizdor no debe estar en 0")
        }
        .toast(isPresenting: $pomodoroModel.isFinished, duration: 3) {
            AlertToast(displayMode: .hud, type: .complete(Color("Primary")), title: "Temporizador concluido", subTitle: "Puedes tomar un descanso")
        }
    }
    
    @ViewBuilder
    func ContextMenuOptions(maxValue: Int, hint: String, onClick: @escaping (Int) -> ()) -> some View {
        ForEach(0...maxValue, id: \.self) { value in
            Button("\(value) \(hint)") {
                onClick(value)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PomodoroViewModel())
    }
}
