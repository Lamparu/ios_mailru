//
//  StopwatchView.swift
//  BFY
//
//  Created by Полина Подчуфарова on 11.12.2021.
//

import SwiftUI

struct StopwatchView: View {
    @State private var isActive = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining_sec: Int = 0
    
    
    var body: some View {
        
        VStack(spacing: 40) {
        
            
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                Circle()
                    .stroke( Color(red: 106, green: 127, blue: 96) , style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                    .rotationEffect(.degrees(-90))// change this string for 15 ios app
  
                
                HStack {
                    
                
                    Text("\((((timeRemaining_sec /  3600)) / 10) != 0 ? String((timeRemaining_sec /  3600)) :  "0" + String((timeRemaining_sec / 3600))):")
                 .font(.largeTitle)
                 .foregroundColor(.white)
                 .fixedSize(horizontal: true, vertical: false)
                
      
                    Text("\((((timeRemaining_sec %  3600) / 60) / 10) != 0 ? String((timeRemaining_sec %  3600) / 60) :  "0"+String((timeRemaining_sec %  3600) / 60)):")
                 .font(.largeTitle)
                 .foregroundColor(.white)
                 .fixedSize(horizontal: true, vertical: false)
                 
                Text("\((((timeRemaining_sec %  3600) % 60) / 10) != 0 ? String((timeRemaining_sec %  3600) % 60) :  "0"+String((timeRemaining_sec %  3600) % 60))")
                                 .font(.largeTitle)
                                 .foregroundColor(.white)
                                 .fixedSize(horizontal: true, vertical: false)
                
                    
                }.frame(width: radius, height: radius )
            
            }.frame(width: radius * 2, height: radius * 2)
                
            
            
            
            HStack(spacing: 25) {

                Image(isActive ? "pause" : "start").resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                    .onTapGesture(perform: {
                    isActive.toggle()
                })
                Spacer()
                    .frame(width: 40)
                Image("cancel").resizable()
                    .frame(width: 100, height: 100)
                    .padding()
                    .onTapGesture(perform: {
                        if (isActive) {
                    isActive = false
                    timeRemaining_sec = 0
                        } else {
                            timeRemaining_sec = 0
                        }
                })
            }
        }.onReceive(timer, perform: { _ in
            guard isActive else { return }
                timeRemaining_sec += 1
            
        })


        
    }
}

struct StopwatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}
