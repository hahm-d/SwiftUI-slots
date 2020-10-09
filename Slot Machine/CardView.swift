//
//  CardView.swift
//  Slot Machine
//
//  Created by Daniel Hahm on 10/9/20.
//

import SwiftUI

struct CardView: View {
    
    //pass down props (binding)
    @Binding var symbol:String
    @Binding var background:Color
    
    var body: some View {
        
        Image(symbol)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .background(background.opacity(0.5))
            .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symbol: Binding.constant("cherry"), background: Binding.constant(Color.green)) //temporary binding value
    }
}
