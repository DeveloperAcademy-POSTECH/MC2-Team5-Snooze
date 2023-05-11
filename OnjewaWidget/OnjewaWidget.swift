//
//  OnjewaWidget.swift
//  OnjewaWidget
//
//  Created by 최효원 on 2023/05/02.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
  
  var timerValue = UserDefaults.shared.integer(forKey: "timerValue")
    
  func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
      print("\(timerValue)")
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        let userDefaults = UserDefaults.standard

        // Generate a timeline with 5 entries at 1 minute intervals
        for minuteOffset in 0 ..< 1 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset,
                                                  to: currentDate)!
//            let timerValue = userDefaults.integer(forKey: "timerValue")
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        // Use policy to determine when the timeline should be refreshed
        let policy: TimelineReloadPolicy = .atEnd
        let timeline = Timeline(entries: entries, policy: policy)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct OnjewaWidgetEntryView : View {
    var entry: Provider.Entry
  var timerValue = UserDefaults.shared.integer(forKey: "timerValue")

    var body: some View {
      Text("\(timerValue)")
    }
}

struct OnjewaWidget: Widget {
    let kind: String = "OnjewaWidget"
  
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            OnjewaWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct OnjewaWidget_Previews: PreviewProvider {
    static var previews: some View {
        OnjewaWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


extension UserDefaults {
    static var shared: UserDefaults {
        let appGroupId = "group.com.wonniiii.onjewa"
        return UserDefaults(suiteName: appGroupId)!
    }
}
