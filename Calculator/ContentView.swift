//
//  ContentView.swift
//  Calculator
//
//  Created by Haris Munir on 8/26/21.
//

import SwiftUI

struct ContentView: View {
    //change
    
    let buttons = [
        ["7", "8", "9", "X"],
        ["4", "5", "6", "X"],
        ["1", "2", "3", "X"],
        ["0", ".", ".", "="]
    ];
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.black.ignoresSafeArea()
           
            VStack {
                
                HStack{
                    Spacer()
                    Text("42").foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack{
                        ForEach(row, id: \.self){ button in
                            Text(button)
                            .font(.system(size: 32))
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                        }
                    }
                
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
