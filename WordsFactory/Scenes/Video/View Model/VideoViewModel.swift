//
//  VideoViewModel.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation
import WebKit

class VideoViewModel: NSObject {
  let request: URLRequest?
  
  override init() {
    if let url = URL(string: "https://learnenglish.britishcouncil.org/general-english/video-zone") {
      self.request = URLRequest(url: url)
    } else {
      self.request = nil
    }
  }
}

extension VideoViewModel: WKNavigationDelegate {
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
               decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    guard navigationAction.request.url?.absoluteString
            .contains("https://learnenglish.britishcouncil.org/general-english/video-zone") == true else {
      decisionHandler(.cancel)
      return
    }
    decisionHandler(.allow)
  }
}
