//
//  Home.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 18/07/2021.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        TabView{
            CharactersPage().tabItem { Image(systemName: "person.3.fill")
                Text("Charactors") }
            ComicsPage().tabItem { Image(systemName: "books.vertical.fill")
                Text("Com")}
        }
    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeScreen()
                .previewDevice("iPhone 11")
        }
    }
}
