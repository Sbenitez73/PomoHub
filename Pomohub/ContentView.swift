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
        Home()
            .environmentObject(pomodoroModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
