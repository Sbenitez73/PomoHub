//
//  AnalogClockView.swift
//  Pomohub
//
//  Created by Santiago Benitez on 10/3/23.
//

import SwiftUI

struct AnalogClockView: View {
    
    @Binding var foregroundColor: Color
    @State private var currentTime: Date = Date.now
    
    let borderWidth: CGFloat = 20
    private let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            let radius = geometry.size.width / 2
            let innerRadius = radius - borderWidth
            
            let centerX = geometry.size.width / 2
            let centerY = geometry.size.height / 2
            
            let center = CGPoint(x:centerX, y:centerY)
            let components = Calendar.current.dateComponents([.hour, .minute, .second], from: currentTime)
            
            let minute = Double(components.minute ?? 0)
            let second = Double(components.second ?? 0)
            
            Circle()
                .foregroundColor(.white)
            
            Circle()
                .foregroundColor(.white)
                .padding(borderWidth)
            
            Path { path in
                for index in 0..<60 {
                    let radian = Angle(degrees: Double(index) * 6 - 90).radians
                    let lineHeight: Double = index % 5 == 0 ? 25 : 0
                    
                    let x1 = centerX + innerRadius * cos(radian)
                    let y1 = centerY + innerRadius * sin(radian)
                    
                    let x2 = centerX + CGFloat((innerRadius - lineHeight)) * cos(radian)
                    let y2 = centerY + (innerRadius - lineHeight) * sin(radian)
                    
                    path.move(to: .init(x: x1, y: y1))
                    path.addLine(to: .init(x: x2, y: y2))
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round))
            .foregroundColor(Color("Gray"))
            
            
            //Path for seconds
            Path { path in
                path.move(to: center)
                
                let  height = innerRadius - 20
                
                let radian = Angle(degrees: second * 6 - 90).radians
                
                let x = centerX + height * cos(radian)
                let y = centerY + height * sin(radian)
                
                path.addLine(to: CGPoint(x: x, y: y))
                
            }
            .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
            .foregroundColor(Color("Accent"))
            
            //Path for minutes
            Path { path in
                path.move(to: center)
                
                let  height = innerRadius - 25
                
                let radian = Angle(degrees: minute * 6 - 90).radians
                
                let x = centerX + height * cos(radian)
                let y = centerY + height * sin(radian)
                
                path.addLine(to: CGPoint(x: x, y: y))
                
            }
            .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round))
            .foregroundColor(Color("Accent"))
            
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(Color("Accent"))
                .position(center)
    }
        .aspectRatio(1,contentMode: .fit)
        .padding(30)
        .onReceive(timer) { time in
            currentTime = time
        }
    
}

    struct AnalogClockView_Previews: PreviewProvider {
        static var previews: some View {
            AnalogClockView(foregroundColor: .constant(.red))
        }
    }}
