//
//  DictionaryViewModel.swift
//  WordsFactory
//
//  Created by National Team on 05.11.2021.
//

import Foundation
import AVFoundation

class DictionaryViewModel {
  var onDidStartRequest: (() -> Void)?
  var onDidEndRequest: (() -> Void)?
  var onDidLoadData: (() -> Void)?
  var onDidReceiveError: ((Error) -> Void)?
  
  let dictionaryService: DictionaryService = DictionaryServiceProxy()
  
  var player: AVPlayer?
  
  var hasWord: Bool {
    word != nil
  }
  
  var wordName: String? {
    word?.word
  }
  
  var phonetic: String? {
    word?.phonetic
  }
  
  var part: String? {
    word?.meanings?.first?.partOfSpeech
  }
  
  var meaningViewModels: [MeaningViewModel] {
    (word?.meanings ?? []).compactMap(\.definitions?.first).map { MeaningViewModel(definition: $0) }
  }
  
  private var word: Word?
  
  func search(word: String?) {
    guard let word = word else {
      return
    }
    onDidStartRequest?()
    dictionaryService.search(word: word).ensure {
      self.onDidEndRequest?()
    }.done { words in
      self.word = words.first
      self.onDidLoadData?()
    }.catch { error in
      self.onDidReceiveError?(error)
    }
  }
  
  func save() {
    guard let word = word else {
      return
    }

    dictionaryService.save(word: word)
  }
  
  func playAudio() {
    guard let url = word?.phonetics?.first?.audioURL else { return }
    let item = AVPlayerItem(url: url)
    player = AVPlayer(playerItem: item)
    player?.volume = 1.0
    player?.play()
  }
}
