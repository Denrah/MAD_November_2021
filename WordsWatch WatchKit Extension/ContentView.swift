//
//  ContentView.swift
//  WordsWatch WatchKit Extension
//
//  Created by National Team on 05.11.2021.
//

import SwiftUI
import WatchConnectivity

enum AppState {
  case timer, test, finish
}

class SessionManager: NSObject, WCSessionDelegate{
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    print(activationState)
  }
  
  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    print(message)
  }
}

struct ContentView: View {
  @State var state: AppState = .timer
  
  let sessionManager = SessionManager()
  
  init() {
    if WCSession.isSupported() {
      print("is supported")
      let session = WCSession.default
      session.delegate = sessionManager
      session.activate()
    } else {
      print("is not supported")
    }
  }
  
  var body: some View {
    switch state {
    case .timer:
      TimerView(state: $state)
    case .test:
      TestView(state: $state)
    case .finish:
      FinishView(state: $state)
    }
  }
}


struct TimerView: View {
  @State var time = 5
  @Binding var state: AppState
  
  var onFinish: (() -> Void)?
  
  var body: some View {
    Text("\(time)").foregroundColor(Color(UIColor(red: 0.892, green: 0.338, blue: 0.163, alpha: 1))).font(Font.init(CTFont.init("Rubik-Bold" as CFString, size: 56))).task {
      time = 5
      _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
        
        if time == 0 {
          timer.invalidate()
          self.state = .test
        } else {
          time -= 1
        }
      })
    }.navigationTitle("Start").navigationBarTitleDisplayMode(.inline)
  }
}


struct TestView: View {
  @Binding var state: AppState
  
  @State var words: [Word] = []
  @State var currentWord = 0
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 10) {
        Text("Some not so long description of word. Not more than 50 symbols.").multilineTextAlignment(.center).foregroundColor(.white.opacity(0.85)).font(Font.init(CTFont.init("Rubik-Medium" as CFString, size: 12))).padding(.horizontal, 16)
        Button("Some word") {
          self.state = .finish
        }.font(Font.init(CTFont.init("Rubik-Regular" as CFString, size: 14))).multilineTextAlignment(.leading)
        Button("Another word") {
          self.state = .finish
        }.font(Font.init(CTFont.init("Rubik-Regular" as CFString, size: 14))).multilineTextAlignment(.leading)
      }
    }.navigationTitle("\(currentWord) of \(words.count)").navigationBarTitleDisplayMode(.inline)
  }
}

struct FinishView: View {
  @Binding var state: AppState
  
  var body: some View {
    VStack {
      Spacer()
      Text("Correct: 9\nIncorrent: 1").multilineTextAlignment(.center).foregroundColor(Color(UIColor(red: 0.471, green: 0.456, blue: 0.427, alpha: 1))).font(Font.init(CTFont.init("Rubik-Regular" as CFString, size: 14))).padding(.bottom, 24)
      Button("Repeat") {
        self.state = .timer
      }.font(Font.init(CTFont.init("Rubik-Regular" as CFString, size: 14))).navigationTitle("Finish").navigationBarTitleDisplayMode(.inline)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
