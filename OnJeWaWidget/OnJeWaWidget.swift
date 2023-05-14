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
    SimpleEntry(date: Date(), animalTime: 0, widgetTitle: "")
  }
  
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    
    let entry = SimpleEntry(date: Date(), animalTime: 0, widgetTitle: "")
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    var widgetTitle = ""
    let currentDate = Date()
    let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: currentDate)!
    
    let homeOutKey = UserDefaults.shared.bool(forKey: "homeOutKey")
    
    if homeOutKey == true {
      widgetTitle = "오늘 주인을 기다린지"
      let currentAnimalHour = UserDefaults.shared.integer(forKey: "animalHour")
      let currentAnimalHourResult = UserDefaults.shared.integer(forKey: "animalHourResult")
      let result = currentAnimalHourResult + currentAnimalHour
      let newAnimalHour = result + 1
      UserDefaults.shared.set(newAnimalHour, forKey: "animalHour")
      
    }else {
      widgetTitle = "오늘 주인과 함께한지"
      let currentAnimalHour = UserDefaults.shared.integer(forKey: "animalHour")
      let currentAnimalHourResult = UserDefaults.shared.integer(forKey: "animalHourResult")
      let result = currentAnimalHourResult + currentAnimalHour
      let newAnimalHour = result + 1
      UserDefaults.shared.set(newAnimalHour, forKey: "animalHour")
    }
        
    let entry = SimpleEntry(date: entryDate, animalTime: UserDefaults.shared.integer(forKey: "animalHour"), widgetTitle: widgetTitle)
    entries.append(entry)
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let animalTime: Int
  let widgetTitle: String
}

struct OnJeWaWidgetEntryView : View {
  var entry: Provider.Entry
  let animalImageKey = UserDefaults.shared.string(forKey: "petTypeKey")
  
  var animalImageName: String {
    switch animalImageKey {
    case "고양이":
      return "cat"
    case "강아지":
      return "dogrun"
    case "토끼":
      return "rabbit"
    case "앵무새":
      return "parrot"
    default:
      return ""
    }
  }

  var body: some View {
    let animalHour = entry.animalTime
    let widgetTitle = entry.widgetTitle
    
    VStack(alignment: .leading) {
      Text(widgetTitle)
        .font(.system(size: 12, weight: .light))
      Text("\(animalHour)시간")
        .foregroundColor(.black)
        .font(.system(size: 20, weight: .bold))
        .padding(.bottom, 3)
      Image(animalImageName)
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


