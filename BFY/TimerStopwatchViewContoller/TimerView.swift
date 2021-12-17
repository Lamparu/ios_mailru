//
//  ContentView.swift
//  BFY
//
//  Created by Полина Подчуфарова on 20.11.2021.
//

import SwiftUI
import UIKit
import AVFoundation

var defaultTimeRemaining_sec: Int = 10
let lineWith: CGFloat = 10
let radius: CGFloat = 150
let systemSoundID: SystemSoundID = 4095



@available(iOS 13.0.0, *) struct TimerView: View {
    @State private var selectedPickerIndexHour = 1
    @State private var selectedPickerIndexMins = 0
    @State private var selectedPickerIndexSecs = 0
    @State private var isActive = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var availableMinutes = Array(0...59)
    var availableSecs = Array(0...59)
    @State private var timeRemaining_sec: Int = 3600
    
    
    var body: some View {
        
        VStack(spacing: 40) {
        
            
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                Circle()
                    .trim(from: 0, to: 1 - CGFloat((availableMinutes[selectedPickerIndexHour] * 3600 + availableMinutes[selectedPickerIndexMins] * 60 + availableSecs[selectedPickerIndexSecs] - timeRemaining_sec)) / CGFloat(availableMinutes[selectedPickerIndexHour] * 3600 + availableMinutes[selectedPickerIndexMins] * 60 + availableSecs[selectedPickerIndexSecs]))
                    .stroke( Color(red: 106, green: 127, blue: 96) , style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut,value: timeRemaining_sec) // change this string for 15 ios app
  
                
                HStack {
                    
                    Menu{
                        Picker( selection: $selectedPickerIndexHour, label: EmptyView()){
                    ForEach(0 ..< availableMinutes.count) {
                        Text("\(self.availableMinutes[$0])")

                    }
                }
                
                    }
                label: {
                    Text("\((((timeRemaining_sec /  3600)) / 10) != 0 ? String((timeRemaining_sec /  3600)) :  "0" + String((timeRemaining_sec / 3600))):")
                 .font(.largeTitle)
                 .foregroundColor(.white)
                 .fixedSize(horizontal: true, vertical: false)
                 
                }
                .onChange(of: selectedPickerIndexHour, perform : { (value) in
                    timeRemaining_sec = availableMinutes[selectedPickerIndexHour] * 3600 + availableMinutes[selectedPickerIndexMins] * 60 + availableSecs[selectedPickerIndexSecs]
                                                    })
                    
                    
                    Menu{
                        Picker( selection: $selectedPickerIndexMins, label: EmptyView()){
                    ForEach(0 ..< availableMinutes.count) {
                        Text("\(self.availableMinutes[$0])")

                    }
                }
                
                    }
                label: {
                    Text("\((((timeRemaining_sec %  3600) / 60) / 10) != 0 ? String((timeRemaining_sec %  3600) / 60) :  "0"+String((timeRemaining_sec %  3600) / 60)):")
                 .font(.largeTitle)
                 .foregroundColor(.white)
                 .fixedSize(horizontal: true, vertical: false)
                 
                }
                        .onChange(of: selectedPickerIndexMins, perform : { (value) in
                            timeRemaining_sec = availableMinutes[selectedPickerIndexHour] * 3600 + availableMinutes[selectedPickerIndexMins] * 60 + availableSecs[selectedPickerIndexSecs]
                                                    })
                
                                        
                                                    
              
                    Menu{
                        Picker(selection: $selectedPickerIndexSecs,
                               label :  EmptyView() ,
                               content: {
                                ForEach(0 ..< availableSecs.count) {
                                    Text("\(self.availableSecs[$0])")
                                }
                        
                                })
                        
                    }
                    label :
                    {      Text("\((((timeRemaining_sec %  3600) % 60) / 10) != 0 ? String((timeRemaining_sec %  3600) % 60) :  "0"+String((timeRemaining_sec %  3600) % 60))")
                                 .font(.largeTitle)
                                 .foregroundColor(.white)
                                 .fixedSize(horizontal: true, vertical: false)
                        
                    }.onChange(of: selectedPickerIndexSecs,
                               perform : { (value) in
                        timeRemaining_sec = availableMinutes[selectedPickerIndexHour] * 3600 + availableMinutes[selectedPickerIndexMins] * 60 + availableSecs[selectedPickerIndexSecs]
                    })
                    
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
                    timeRemaining_sec = availableMinutes[selectedPickerIndexHour] * 3600 + availableMinutes[selectedPickerIndexMins] * 60 + availableSecs[selectedPickerIndexSecs]
                        } else {
                            selectedPickerIndexHour = 1
                            selectedPickerIndexMins = 0
                            selectedPickerIndexSecs = 0
                            timeRemaining_sec = availableMinutes[selectedPickerIndexHour] * 3600 + availableMinutes[selectedPickerIndexMins] * 60 + availableSecs[selectedPickerIndexSecs]
                        }
                })
            }
        }.onReceive(timer, perform: { _ in
            guard isActive else { return }
            if timeRemaining_sec > 0 {
                timeRemaining_sec -= 1
            } else {
                AudioServicesPlaySystemSound (systemSoundID)
                isActive = false
//                let EndingScreenViewController = EndingScreenViewController()
//                //EndingScreenViewController.delegate = self
//                let navController = UINavigationController(rootViewController: EndingScreenViewController)
//                    .present(navController, animated: true, completion: nil)
                timeRemaining_sec = availableMinutes[selectedPickerIndexHour] * 3600 + availableMinutes[selectedPickerIndexMins] * 60 + availableSecs[selectedPickerIndexSecs]
            }
            
        })


        
    }

}
