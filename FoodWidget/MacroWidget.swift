//
//  FoodWidget.swift
//  FoodWidget
//
//  Created by Timmy Nguyen on 4/6/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    let foodService = FoodService()
    
    func placeholder(in context: Context) -> MealPlanEntry {
        return MealPlanEntry(date: Date(), mealPlan: MealPlan.sample, appTheme: Settings.shared.currentTheme)
    }

    func getSnapshot(in context: Context, completion: @escaping (MealPlanEntry) -> ()) {
        let mealPlan = foodService.getMealPlan(date: .now) ?? MealPlan.sample
        let mealPlanEntry = MealPlanEntry(date: .now, mealPlan: mealPlan, appTheme: Settings.shared.currentTheme)
        completion(mealPlanEntry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MealPlanEntry>) -> ()) {
        var entries: [MealPlanEntry] = []

        // Update every 24 hours
        let nextUpdate = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: .now))!
        let mealPlan = foodService.getMealPlan(date: .now) ?? MealPlan.sample
        let entry = MealPlanEntry(date: .now, mealPlan: mealPlan, appTheme: Settings.shared.currentTheme)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct MealPlanEntry: TimelineEntry {
    let date: Date            // date to update widget
    let mealPlan: MealPlan   // properties of widget
    let appTheme: AppTheme
}

struct MacroWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        MacroMediumView(entry: entry)
    }
}

struct MacroWidget: Widget {
    static let kind: String = "MacroWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: MacroWidget.kind, provider: Provider()) { entry in
            MacroWidgetEntryView(entry: entry)
                .containerBackground(entry.appTheme.cellBackground.color, for: .widget) // use this for widget background. using background() has padding
        }
        .configurationDisplayName("Macros")  // shown in widget selector
        .description("Display daily macros.")
        .supportedFamilies([.systemMedium])
    }
}

//#Preview(as: .systemSmall) {
//    MacroWidget()
//} timeline: {
//    MealPlanEntry(date: .now, mealPlan: MealPlan.sample)
//    MealPlanEntry(date: .now, mealPlan: MealPlan.sample)
//}

// Note: Add all files that are used within widget to 'FoodWidgetExtension' target (including .xcdatamodeld)
/**
 - Core data is a sqllite wrapper, sqlite is is just a file stored on users device
 - To share data between different targets on the same device you add them to an App Group
 */
