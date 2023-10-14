//
//  NavBar.swift
//  Pomohub
//
//  Created by Santiago Benitez on 10/14/23.
//

import SwiftUI

struct NavBar: View {
    
    var subtitle: String
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack() {
                Spacer()
                VStack(spacing:4) {
                    Text("PomodoroHub")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color("Background"))
                    Text(subtitle)
                        .foregroundColor(Color("Background"))
                }
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "person.circle.fill")
                })
                
            }
            .padding()
            .accentColor(.white)
            .font(.headline)
            .background(
                Color("Primary").ignoresSafeArea()
            )
            .cornerRadius(50, corners: [.bottomLeft,])
            
        }
        
        
        
    }
    
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NavBar(subtitle: "subtite")
            Spacer()
        }
    }
}
