//
//  ContentView.swift
//  Calculator
//
//  Created by Haris Munir on 8/26/21.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"

    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
    var buttonTextColor: Color {
        switch self {
        case .clear, .negative, .percent:
            return Color(.black)
        default:
            return Color(.white)
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {

    @State var value = "0"
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
    @State var hasDecimal = false;

    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]

    var body: some View {
        ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack (spacing: 12) {

                // The main Display
                HStack {
                    Spacer()
                    Text(value)
                        .foregroundColor(.white)
                        .scaledToFit()
                        .font(.system(size: 100, design: .default))
                }
                .padding()

                // Buttons, loop goes through arrays making each button
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.buttonProcess(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 46))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(item.buttonTextColor)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }

    
    
    func buttonProcess(button: CalcButton) {
        switch button {
        
        case .add, .subtract, .mutliply, .divide, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0
                hasDecimal = false
            }
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0
                hasDecimal = false
            }
            else if button == .mutliply {
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0
                hasDecimal = false
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0
                hasDecimal = false
            }
            else if button == .equal {
                
                let runningValue = Double(self.runningNumber)
                let currentValue = Double(self.value) ?? 0
                
                hasDecimal = false;
                
               
                
                
                switch self.currentOperation {
                    case .add:
                        self.value = "\((runningValue + currentValue))"
                    case .subtract:
                        self.value = "\(runningValue - currentValue)"
                    case .multiply:
                        self.value = "\(runningValue * currentValue)"
                    case .divide:
                        self.value = "\(runningValue / currentValue)"
                    case .none:
                        break
                }
            }
            
            if button != .equal {
                self.value = ""
            }
            
        case .clear:
            self.value = "0"
            
        case .percent:
            let currentValue = Double(self.value) ?? 0
            self.value = "\(currentValue * 0.01)"
            break
        
        case .decimal:
            if(hasDecimal == false){
            let currentValue = Int(self.value) ?? 0
            self.value = "\(currentValue)."
                hasDecimal = true
            }
            break
            
        case .negative:
            let currentValue = Int(self.value) ?? 0
            self.value = "\(currentValue * -1)"
            break
            
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    //Button Width
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (5 * 11.5)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 11.5)) / 4
    }
    
    //Button Height
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
