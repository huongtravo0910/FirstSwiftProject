//
//  CharactersView.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 18/07/2021.
//

import SwiftUI
import Resolver

struct CharactersPage: View {
    @ObservedObject var characterViewModel: CharacterViewModel = Resolver.resolve()
    @State var isErrorDialogShown: Bool = false
    var body: some View {
        NavigationView{
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
                VStack( spacing: 15, content: {
                    HStack(spacing: 10, content: {
                        Image(systemName: "magnifyingglass").foregroundColor(.gray)
                        TextField("Search Characters", text:
                                    $characterViewModel.searchQuery).autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/).disableAutocorrection(true)
                    }).padding(.vertical, 10).padding(.horizontal, 10).background(Color.white).shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5).shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5).accessibility(identifier: "search_text_field")
                }).padding()
                
                switch characterViewModel.state {
                case .idle:
                    Color.yellow
                case .loading:
                    ProgressView("Loading Assets...")
                case .failed(let error):
                    if(isErrorDialogShown){ErrorDialog(errorDes: .constant(error.description) , isShown: $isErrorDialogShown)}
                    Color.black
                case .loaded(let characters):
                    if(characters.isEmpty){
                        Text("No character found")
                    }
                    ForEach(characters){ data in
                        
                        CharacterRow(character: data)
                    }
                }
            }).navigationTitle("Marvel")
            
        }
        
    }
}

struct CharactersPage_Previews: PreviewProvider {
    static var previews: some View {
        CharactersPage()
            .previewDevice("iPhone 11")
    }
}

