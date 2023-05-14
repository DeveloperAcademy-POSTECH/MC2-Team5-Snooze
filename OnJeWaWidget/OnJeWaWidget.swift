//
//  OnJeWaWidget.swift
//  OnJeWaWidget
//
//  Created by 최효원 on 2023/05/14.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
      let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!

          let entry = SimpleEntry(date: entryDate)
          entries.append(entry)

          let timeline = Timeline(entries: entries, policy: .atEnd)
      
      UserDefaults.standard.dictionaryRepresentation().forEach { (key, value) in
          UserDefaults.shared.set(value, forKey: key)
      }
      print(UserDefaults.shared.integer(forKey: "animalHour"))
      
          completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct OnJeWaWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
      let animalHour = UserDefaults.shared.integer(forKey: "animalHour")
      
      VStack(alignment: .leading) {
        Text("오늘 주인을 기다린지")
          .font(.system(size: 12, weight: .light))
        Text("\(animalHour)시간")
          .foregroundColor(.black)
          .font(.system(size: 20, weight: .bold))
          .padding(.bottom, 3)
        Image("cat")
          .resizable()
          .frame(width: 117, height: 81)
          .aspectRatio(.zero, contentMode: .fill)
      }
    }
}

struct OnJeWaWidget: Widget {
    let kind: String = "OnJeWaWidget"


    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            OnJeWaWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct OnJeWaWidget_Previews: PreviewProvider {
    static var previews: some View {
        OnJeWaWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
