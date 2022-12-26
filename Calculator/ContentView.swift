
import SwiftUI

enum CalculationButtoms: String{
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
    case substract = "-"
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case clear = "AC"
    case decimal = ","
    case percent = "%"
    case negative = "+/-"
    
    var buttonColours: Color{
        switch self{
        case .clear,.negative,.equal:
            return Color.black
        case .add,.substract,.divide,.multiply:
            return Color.accentColor
        default:
            return Color.cyan
            
        }
    }
}
enum Operations{
    case add,substract,divide,multiply,none
}
struct ContentView: View {
    
    @State var values = "0"
    @State var runningNums = 0
    @State var currentOperations: Operations = .none
    let buttoms:[[CalculationButtoms]]=[
        [.one,.two,.three,.zero],
        [.four,.five,.six,.decimal],
        [.seven,.eight,.nine,.percent],
        [.add,.substract,.divide,.multiply],
        [.clear,.negative,.equal]
    ]
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                HStack{
                    Spacer()
                    
                    Text(values).monospacedDigit()
                        .font(.system(size: 64))
                        .foregroundColor(.black)
                }
                .padding()
                ForEach(buttoms,id:\.self){ row in
                    HStack (spacing:12){
                        ForEach(row,id:\.self){ item in
                            Button(action: {
                                self.type(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 37))
                                    .frame(
                                        width:self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                      )
                                    .background(item.buttonColours)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(15)
                                    .monospacedDigit()
                            })
                        }
                        
                    }
                    .padding(.bottom,3)
                }
            }
        }
    }
    func type(button:CalculationButtoms){
        switch button{
        case .add,.substract,.divide,.multiply,.equal:
            if button == .add{
                self.currentOperations = .add
                self.runningNums = Int(self.values) ?? 0
            }
            else if button == .substract{
                self.currentOperations = .substract
                self.runningNums = Int(self.values) ?? 0
            }
            else if button == .divide{
                self.currentOperations = .divide
                self.runningNums = Int(self.values) ?? 0
            }
            else if button == .multiply{
                self.currentOperations = .multiply
                self.runningNums = Int(self.values) ?? 0
            }
            else if button == .equal{
                let runningV = self.runningNums
                let currentV = Int(self.values) ?? 0
                switch self.currentOperations{
                    
                case .add: self.values = "\(runningV + currentV )"
                case .substract: self.values = "\(runningV - currentV )"
                case .divide: self.values = "\(runningV / currentV )"
                case .multiply: self.values = "\(runningV * currentV )"
                case .none:
                    break
                    }
                }
            if button != .equal{
                self.values = "0"
            }
            
        case.clear:
            self.values = "0"
        case.decimal,.negative,.percent:
            break
        default:
            let numbers = button.rawValue
            if self.values == "0"{
                values = numbers}
            else{
                self.values = "\(self.values)\(numbers)"
            }
        }}
    func buttonWidth(item:CalculationButtoms)-> CGFloat{
        if item == .zero{
        return((UIScreen.main.bounds.width - (4*12))/4)*1
        }
        return(UIScreen.main.bounds.width - (5*12))/4
        
    }
    func buttonHeight()->CGFloat {
    return(UIScreen.main.bounds.width - (5*12))/4 }
                                   
                                   
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

