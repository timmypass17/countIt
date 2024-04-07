//
//  FoodWidget.swift
//  FoodWidget
//
//  Created by Timmy Nguyen on 4/6/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> MealPlanEntry {
        return MealPlanEntry(date: Date(), mealPlan: MealPlan.sample)
    }

    func getSnapshot(in context: Context, completion: @escaping (MealPlanEntry) -> ()) {
        let mealPlan = CoreDataStack.shared.getMealPlan(for: .now) ?? MealPlan.sample
        let mealPlanEntry = MealPlanEntry(date: .now, mealPlan: mealPlan)
        completion(mealPlanEntry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MealPlanEntry>) -> ()) {
        var entries: [MealPlanEntry] = []

        // Update every 24 hours
        let nextUpdate = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: .now))!
        let mealPlan = CoreDataStack.shared.getMealPlan(for: .now) ?? MealPlan.sample
        let entry = MealPlanEntry(date: .now, mealPlan: mealPlan)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct MealPlanEntry: TimelineEntry {
    let date: Date            // date to update widget
    let mealPlan: MealPlan?   // properties of widget
}

struct MacroWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        MacroMediumView(entry: entry)
    }
}

struct MacroWidget: Widget {
    let kind: String = "MacroWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MacroWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MacroWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Macros")  // shown in widget selector
        .description("Display daily macros.")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemSmall) {
    MacroWidget()
} timeline: {
    MealPlanEntry(date: .now, mealPlan: MealPlan.sample)
    MealPlanEntry(date: .now, mealPlan: MealPlan.sample)
}

// Note: Add all files that are used within widget to 'FoodWidgetExtension' target (including .xcdatamodeld)
/**
 - Core data is a sqllite wrapper, sqlite is is just a file stored on users device
 - To share data between different targets on the same device you add them to an App Group
 */
