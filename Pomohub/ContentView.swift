//
//  ContentView.swift
//  Pomohub
//
//  Created by Santiago Benitez on 10/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pomodoroModel: PomodoroViewModel
    var body: some View {
        GeometryReader { reader in
                            Color("Primary")
                                .frame(height: reader.safeAreaInsets.top, alignment: .top)
                                .ignoresSafeArea()
            Home()
                .environmentObject(pomodoroModel)
                        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static let pomodoroViewModel = PomodoroViewModel()
    static var previews: some View {
        ContentView()
            .environmentObject(pomodoroViewModel)
    }
}
