//
//  CharacterRow.swift
//  Marvel_APIApp
//
//  Created by Tra Vo on 25/07/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterRow: View {
    var character : Character
    var body: some View{
        HStack(alignment: .top, spacing: 15){
            WebImage(url: extractImage(data: character.thumbnail)).resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/).frame(width: 150, height: 150).cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(character.name).font(.title3).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).accessibility(identifier: "character_row")
                Text(character.description).font(.caption).foregroundColor(.gray).lineLimit(4).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                ///Links
                HStack(spacing: 10){
                    ForEach(character.urls, id: \.self){
                        data in
                        
                        NavigationLink(
                            destination: WebView(url: extractURL(data: data)).navigationTitle(extractURLType(data: data)).accessibility(identifier: "character"),
                            label: {
                                Text(extractURLType(data: data))
                            })
                    }.accessibility(identifier: "go_to_webview_button").accessibilityLabel("character")
                }
            })
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
        }.padding(.horizontal)
    }
    
    func extractImage(data: [String:String]) -> URL{
        //combining both and forming image...
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        return URL(string: "\(path).\(ext)")!
    }
    
    func extractURL(data: [String:String]) -> URL{
        let url = data["url"] ?? ""
        return URL(string: url)!
    }
    
    func extractURLType(data: [String:String]) -> String{
        let type = data["type"] ?? ""
        return type.capitalized
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRow(character: Character(id: 0, name: "ABC", description: "XYz", thumbnail: ["": ""], urls: [["xzy" : "xyz"]]))
    }
}
