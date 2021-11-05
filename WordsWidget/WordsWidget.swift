//
//  WordsWidget.swift
//  WordsWidget
//
//  Created by National Team on 05.11.2021.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), configuration: ConfigurationIntent(), totalWords: 3125, learnedWords: 41)
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), configuration: configuration, totalWords: 3125, learnedWords: 41)
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    
    let totalWords = UserDefaults(suiteName: "group.words")?.integer(forKey: "totalWords") ?? 0
    let learnedWords = UserDefaults(suiteName: "group.words")?.integer(forKey: "learnedWords") ?? 0
    
    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 3 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate, configuration: configuration, totalWords: totalWords, learnedWords: learnedWords)
      entries.append(entry)
    }
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let configuration: ConfigurationIntent
  let totalWords: Int
  let learnedWords: Int
}

struct WordsWidgetEntryView : View {
  var entry: Provider.Entry
  
  var body: some View {
    VStack(spacing: 16) {
      HStack {
        Text("WordsFactory").foregroundColor(.white).font(Font.init(CTFont.init("Rubik-Bold" as CFString, size: 32)))
        Spacer()
      }.padding(.horizontal, 16).frame(height: 51).background(LinearGradient(colors: [Color(UIColor(red: 0.89, green: 0.337, blue: 0.165, alpha: 1)), Color(UIColor(red: 0.949, green: 0.624, blue: 0.247, alpha: 1))], startPoint: .leading, endPoint: .trailing))
      HStack {
        Text("My Dictionary").foregroundColor(.black).font(Font.init(CTFont.init("Rubik-Medium" as CFString, size: 20)))
        Spacer()
        Text("\(entry.totalWords) Words").foregroundColor(.black.opacity(0.5)).font(Font.init(CTFont.init("Rubik-Regular" as CFString, size: 14)))
      }.padding(.horizontal, 16)
      HStack {
        Text("I already remember ").foregroundColor(.black).font(Font.init(CTFont.init("Rubik-Medium" as CFString, size: 20)))
        Spacer()
        Text("\(entry.learnedWords) Words").foregroundColor(.black.opacity(0.5)).font(Font.init(CTFont.init("Rubik-Regular" as CFString, size: 14)))
      }.padding(.horizontal, 16)
      Spacer()
    }
  }
}

@main
struct WordsWidget: Widget {
  let kind: String = "WordsFactory"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      WordsWidgetEntryView(entry: entry)
    }
    .configurationDisplayName("WordsFactory")
    .description("WordsFactory")
    .supportedFamilies([.systemMedium])
  }
}

struct WordsWidget_Previews: PreviewProvider {
  static var previews: some View {
    WordsWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), totalWords: 3125, learnedWords: 41))
      .previewContext(WidgetPreviewContext(family: .systemMedium))
  }
}
