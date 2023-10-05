//
//  Home.swift
//  Pomohub
//
//  Created by Santiago Benitez on 10/4/23.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var pomodoroModel: PomodoroViewModel
    var body: some View {
        VStack {
            Text("Pomodoro Timer")
                .font(.title2.bold())
            
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
                        
                        Text(pomodoroModel.timerValue)
                            .font(.system(size: 45, weight: .light))
                            .rotationEffect(.init(degrees: -90))
                            .animation(.none, value: pomodoroModel.progress)
                    }
                    .padding(40)
                    .frame(height: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .animation(.easeInOut, value: pomodoroModel.progress)
                }
                .onTapGesture( perform: {
                    pomodoroModel.progress = 0.5
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
            HStack(spacing: 25) {
                Text("25")
                    .font(.system(size: 50 ).bold())
                Text(":")
                    .font(.system(size: 50 ).bold())
                    .foregroundStyle(Color("ThinGray"))
                Text("00")
                    .font(.system(size: 50 ).bold())
                Text(":")
                    .font(.system(size: 50 ).bold())
                    .foregroundStyle(Color("ThinGray"))
                Text("00")
                    .font(.system(size: 50 ).bold())
            }
            .padding(20)
            .background{
                Rectangle()
                    .fill(Color("Gray"))
                    .cornerRadius(20)
            }
            
            // Stop and Pause buttons
            HStack(spacing: 20) {
                HStack {
                    Button(action: {}) {
                        HStack{
                            Image(systemName: "pause")
                                .font(.title2.bold())
                                .foregroundColor(Color("Background"))
                            Text("Pausa")
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
                    Button(action: {}) {
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
            
            
        }
        .padding()
        .background{
            Color("Background")
                .ignoresSafeArea()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PomodoroViewModel())
    }
}
