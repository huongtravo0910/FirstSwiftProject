//
//  ErrorDialog.swift
//  Marvel_API_App_Example
//
//  Created by Tra Vo on 18/08/2021.
//

import SwiftUI

struct ErrorDialog: View {
    
    @Binding var errorDes: String
    @Binding var isShown: Bool
    
    var body: some View {
        
        ZStack(){
            
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack{
                Text(errorDes)
                Button(action: {
                    isShown = !isShown
                }, label: {
                    /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(10)
                })
            }.padding().frame(
                width: 300,
                height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color.white
                ).cornerRadius(10)
        }
        
        
        
    }
}

struct ErrorDialog_Previews: PreviewProvider {
    static var previews: some View {
        ErrorDialog(errorDes: .constant("ABC"), isShown: .constant(true))
    }
}
