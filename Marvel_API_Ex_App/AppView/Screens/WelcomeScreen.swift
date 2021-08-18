//
//  WelcomeScreen.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 25/07/2021.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        NavigationView{
            NavigationLink(
                destination: HomeScreen(),
                label: {
                    Text("Welcome to Marvel's World").accessibility(identifier: "welcome button")
                }).accessibility(identifier: "welcome_button" )
        }
        
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
