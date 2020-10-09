//
//  ContentView.swift
//  Slot Machine
//
//  Created by Daniel Hahm on 10/9/20.
//

import SwiftUI

struct ContentView: View {
    
   @State private var symbols = ["apple", "star", "cherry"]
   @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
   @State private var credits = 1000
    private var betAmount = 5
    
    var body: some View {
        ZStack {
            //background
            Rectangle().foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle().foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                
                Spacer()
                
                //title
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("Slot Machine")
                        .bold()
                        .foregroundColor(.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }.scaleEffect(2)
                
               Text("Credits: " + String(credits))
                .foregroundColor(.black)
                .padding(.all, 10)
                .background(Color.white.opacity(0.5))
                .cornerRadius(20)
                
                Spacer()
                
                //cards
                VStack {
                    HStack{
                        Spacer()
                        //passing down state symbols values at number index
                        CardView(symbol: $symbols[numbers[0]], background: $backgrounds[0])
                        CardView(symbol: $symbols[numbers[1]], background: $backgrounds[1])
                        CardView(symbol: $symbols[numbers[2]], background: $backgrounds[2])

                    }
                    HStack{
                        Spacer()
                        //passing down state symbols values at number index
                        CardView(symbol: $symbols[numbers[3]], background: $backgrounds[3])
                        CardView(symbol: $symbols[numbers[4]], background: $backgrounds[4])
                        CardView(symbol: $symbols[numbers[5]], background: $backgrounds[5])

                    }
                    HStack{
                        Spacer()
                        //passing down state symbols values at number index
                        CardView(symbol: $symbols[numbers[6]], background: $backgrounds[6])
                        CardView(symbol: $symbols[numbers[7]], background: $backgrounds[7])
                        CardView(symbol: $symbols[numbers[8]], background: $backgrounds[8])

                    }
                }
                
                Spacer()
                
                HStack (spacing:20){
                    VStack {
                        Button(action: {
                            
                            //process single spin
                            self.processResults()
                            
                        }) {
                            Text("Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        
                        Text("\(betAmount) credits")
                            .padding(.top, 10)
                            .font(.footnote)
                    }
                    
                    VStack {
                        Button(action: {
                            
                            //process max spin
                            self.processResults(true)
                            
                        }) {
                            Text("Max Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding([.leading, .trailing], 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        
                        Text("\(betAmount * 5) credits")
                            .padding(.top, 10)
                            .font(.footnote)
                    }
                    
                }
                
                Spacer()
            }
        }
    }
    
    //method for button
    func processResults(_ isMax:Bool = false){ //initial parameter to false
        // Set background to white initially (map)
        self.backgrounds = self.backgrounds.map({ _ in
            Color.white
        })
        
        if isMax {
            //spin all cards
            //change image
            self.numbers = self.numbers.map({ _ in
                Int.random(in: 0...self.symbols.count - 1)
            })
        }else {
            //spin middle
            
            //change image for 3,4,5
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1)
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1)
        }
        
        // check winnings
        processWin(isMax)
    }
    
    func processWin(_ isMax:Bool = false) {
        
        var matches = 0 //keep track of all matches
        
        if !isMax {
            //processing for single spin
            if isMatch(3, 4, 5) {matches += 1}
            
        }else{
            //processing for max spin
            
            //Top row
            if isMatch(0, 1, 2) {matches += 1}
            //Middle row
            if isMatch(3, 4, 5) {matches += 1}
            //Bottom row
            if isMatch(6, 7, 8) {matches += 1}
            //Diagonal top left to bottom right
            if isMatch(0, 4, 8) {matches += 1}
            //Diagonal top right to bottom left
            if isMatch(2, 4, 6) {matches += 1}
            
        }
        //Check matches and distribute credits
        if matches > 0 {
           //at least one win
            self.credits += matches * betAmount * 3
        }else if !isMax {
            // 0 wins, single spin
            self.credits -= betAmount
        }else {
            // 0 wins, max spin
            self.credits -= betAmount * 5
        }
    
    }
    
    func isMatch(_ index1:Int, _ index2:Int, _ index3:Int) ->
    Bool {
        if self.numbers[index1] == self.numbers[index2] && self.numbers[index2] == self.numbers[index3] {
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            
            return true
        }
        return false
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
