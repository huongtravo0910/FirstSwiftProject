//
//  WebView.swift
//  Marvel_API_App_Example
//
//  Created by Tra Vo on 07/08/2021.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: url))
        return view
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
