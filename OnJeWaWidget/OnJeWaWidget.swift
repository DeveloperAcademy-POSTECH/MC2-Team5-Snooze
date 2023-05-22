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
    SimpleEntry(date: Date(), animalTime: 0, widgetTitle: "", lockWidgetTitle: "")
  }
  
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    
    let entry = SimpleEntry(date: Date(), animalTime: 0, widgetTitle: "", lockWidgetTitle: "")
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
       var widgetTitle = ""
       var lockWidgetTitle = ""
       let currentDate = Date()
       let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!

       let homeOutKey = UserDefaults.shared.bool(forKey: "homeOutKey")

       if homeOutKey == true {
           widgetTitle = "오늘 주인을 기다린지"
           lockWidgetTitle = "외출중"
       } else {
           widgetTitle = "오늘 주인과 함께한지"
           lockWidgetTitle = "막둥이랑"
       }

    let currentAnimalHour = UserDefaults.shared.integer(forKey: "animalHour")
    let animalType = UserDefaults.shared.string(forKey: "petTypeKey")
    
    let entry = SimpleEntry(date: entryDate, animalTime: currentAnimalHour, widgetTitle: widgetTitle, lockWidgetTitle: lockWidgetTitle)
    entries.append(entry)
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
   }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let animalTime: Int
  let widgetTitle: String
  let lockWidgetTitle: String
}

struct OnJeWaWidgetEntryView : View {
  var entry: Provider.Entry
  @Environment(\.widgetFamily) var widgetFamily
  let animalType = UserDefaults.shared.string(forKey: "petTypeKey")
  
  var animalImageName: [String: Int] {
    switch animalType {
    case "고양이":
      return ["cat":4]
    case "강아지":
      return ["dog":4]
    case "토끼":
      return ["rabbit":24]
    case "앵무새":
      return ["parrot":6]
    default:
      return ["":0]
    }
  }
  
  
  
  var body: some View {
    let animalHour = entry.animalTime //0
    let widgetTitle = entry.widgetTitle
    let lockWidgetTitle = entry.lockWidgetTitle
    
    
    if #available(iOSApplicationExtension 16.0, *) {
      switch widgetFamily {

      case .accessoryCircular:
        ZStack {
          AccessoryWidgetBackground()
          VStack {
            Image("dogrun_white")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 16, height: 11)
            Text("\(animalHour == 0 ? animalHour : animalHour + animalImageName.values.first!)시간")
              .foregroundColor(.white)
              .font(.system(size: 14, weight: .bold))
            Text(lockWidgetTitle)
              .foregroundColor(.white)
              .font(.system(size: 8, weight: .regular))
          }
        }

      case .systemSmall:
        VStack(alignment: .leading) {
          Text(widgetTitle)
            .font(.system(size: 12, weight: .light))
          Text("\(animalHour == 0 ? animalHour : animalHour + animalImageName.values.first!)시간")
            .foregroundColor(.black)
            .font(.system(size: 20, weight: .bold))
            .padding(.bottom, 3)
          Image(String(describing: animalImageName.keys.first!))
            .resizable()
            .frame(width: 117, height: 81)
            .aspectRatio(.zero, contentMode: .fill)
        }

      default:
        Text("error")
      }
    }else {
      switch widgetFamily {
      case .systemSmall:
        VStack(alignment: .leading) {
          Text(widgetTitle)
            .font(.system(size: 12, weight: .light))
          Text("\(animalHour == 0 ? animalHour : animalHour + animalImageName.values.first!)시간")
            .foregroundColor(.black)
            .font(.system(size: 20, weight: .bold))
            .padding(.bottom, 3)
          Image(String(describing: animalImageName.keys.first!))
            .resizable()
            .frame(width: 117, height: 81)
            .aspectRatio(.zero, contentMode: .fill)
        }
      default:
        Text("error")
      }
    }
  }
  
  @main
  struct OnJeWaWidget: Widget {
    let kind: String = "OnJeWaWidget"
    
    private let supportedFamilies:[WidgetFamily] = {
      if #available(iOSApplicationExtension 16.0, *) {
        return [.systemSmall, .accessoryCircular]
      } else {
        return [.systemSmall]
      }
    }()
    
    var body: some WidgetConfiguration {
      StaticConfiguration(kind: kind, provider: Provider()) { entry in
        OnJeWaWidgetEntryView(entry: entry)
      }
      .configurationDisplayName("My Widget")
      .description("This is an example widget.")
      .supportedFamilies(supportedFamilies)
    }
  }
}

