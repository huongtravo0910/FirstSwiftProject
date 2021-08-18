//
//  ComicsView.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 18/07/2021.
//

import SwiftUI
import Resolver

struct ComicsPage: View {
    @ObservedObject var comicViewModel: ComicViewModel = Resolver.resolve()
    @State var isErrorDialogShown: Bool = false
    var body: some View {
        
        switch comicViewModel.state {
        case .idle:
            Color.orange.onAppear(){
                comicViewModel.fetchComics{}
            }
        case .loading:
            ProgressView("Loading Assets...")
        case .failed(let error):
            //TODO: Create an Error View
            if(isErrorDialogShown){ErrorDialog(errorDes: .constant(error.description) , isShown: $isErrorDialogShown)}
            Color.black
        case .loaded(let comics):
            NavigationView{
                ScrollView(content: {
                    
                    VStack(spacing: 15){
                        ForEach(comics){
                            comic in
                            ComicRow(character: comic)
                        }
                    }
                    .padding(.bottom)
                    
                })
                .navigationTitle("Marvel's Comics")
            }
        }
    }
}


struct ComicsPage_Previews: PreviewProvider {
    static var previews: some View {
        ComicsPage()
    }
}
