//
//  ContentView.swift
//  BFY
//
//  Created by Полина Подчуфарова on 20.11.2021.
//

import SwiftUI

var defaultTimeRemaining_sec: Int = 10
let defaultTimeRemaining_min: CGFloat = 100
let defaultTimeRemaining_h: CGFloat = 100
let lineWith: CGFloat = 10
let radius: CGFloat = 150

@available(iOS 13.0.0, *) struct ContentView: View {
    
    @State private var isActive = false
    @State private var timeRemaining_sec: Int = defaultTimeRemaining_sec
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 40) {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                Circle()
                    .trim(from: 0, to: 1 - CGFloat((defaultTimeRemaining_sec - timeRemaining_sec)) / CGFloat(defaultTimeRemaining_sec))
                    .stroke( Color(red: 106, green: 127, blue: 96) , style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut,value: timeRemaining_sec) // change this string for 15 ios app
                Text("\((timeRemaining_sec %  3600) / 60):\(Int((timeRemaining_sec % 3600) % 60))").font(.largeTitle).foregroundColor(.white)
            }.frame(width: radius * 2, height: radius * 2)
            
            HStack(spacing: 25) {
//                Label("\(isActive ? "Pause" : "Play")", systemImage: "\(isActive ? "pause.fill" : "play.fill")").foregroundColor(isActive ? .red : .yellow).font(.title).onTapGesture(perform: {
//                    isActive.toggle()
//                })
                //Image("play.png")
                Image(isActive ? "pause" : "start").resizable()
                    //.position(CGPoint(x: 5, y:  20))
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
                    isActive = false
                    timeRemaining_sec = defaultTimeRemaining_sec
                })
            }
        }.onReceive(timer, perform: { _ in
            guard isActive else { return }
            if timeRemaining_sec > 0 {
                timeRemaining_sec -= 1
            } else {
                isActive = false
                timeRemaining_sec = defaultTimeRemaining_sec
            }
        })
        
        
    }
}
