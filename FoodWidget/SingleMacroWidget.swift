////
////  SingleMacroWidget.swift
////  FoodApp
////
////  Created by Timmy Nguyen on 4/6/24.
////
//
//import SwiftUI
//import WidgetKit
//import AppIntents
//
//struct SingleMacroProvider: AppIntentTimelineProvider {
//    func placeholder(in context: Context) -> SingleMacroEntry {
//        return SingleMacroEntry(date: .now, mealPlan: MealPlan.sample, nutrient: WidgetNutrient.allNutrients[0])
//    }
//    
//    func snapshot(for configuration: SelectNutrientIntent, in context: Context) async -> SingleMacroEntry {
//        let mealPlan = CoreDataStack.shared.getMealPlan(for: .now) ?? MealPlan.sample
//        return SingleMacroEntry(date: .now, mealPlan: mealPlan, nutrient: configuration.nutrient)
//    }
//    
//    func timeline(for configuration: SelectNutrientIntent, in context: Context) async -> Timeline<SingleMacroEntry> {
//        var entries: [SingleMacroEntry] = []
//        let mealPlan = CoreDataStack.shared.getMealPlan(for: .now) ?? MealPlan.sample
//        let entry = SingleMacroEntry(date: .now, mealPlan: mealPlan, nutrient: configuration.nutrient)
//        entries.append(entry)
//        let timeline = Timeline(entries: entries, policy: .never)
//        return timeline
//    }
//    
//    
//}
//
//
//struct SelectNutrientIntent: WidgetConfigurationIntent {
//    static var title: LocalizedStringResource = "Widget Nutrient"
//    static var description: IntentDescription = IntentDescription("Select Widget Nutrient")
//    
//    @Parameter(title: "Nutrient")
//    var nutrient: WidgetNutrient
//}
//
//struct SingleMacroEntry: TimelineEntry {
//    let date: Date
//    let mealPlan: MealPlan?
//    let nutrient: WidgetNutrient
//}
//
//struct WidgetNutrient: AppEntity {
//    var nutrientID: NutrientID
//    var color: Color
//    var id: String {    // required by AppEntity
//        nutrientID.description
//    }
//    
//    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Widget Nutrient"
//    static var defaultQuery = WidgetNutrientQuery()
//    
//    var displayRepresentation: DisplayRepresentation {
//        DisplayRepresentation(title: "\(nutrientID.description)")
//    }
//    
//    static let allNutrients: [WidgetNutrient] = {
//        var nutrients: [WidgetNutrient] = [
//            WidgetNutrient(nutrientID: .calories, color: .blue),
//            WidgetNutrient(nutrientID: .carbs, color: .yellow),
//            WidgetNutrient(nutrientID: .protein, color: .pink),
//            WidgetNutrient(nutrientID: .totalFat, color: .green),
//        ]
//        
//        let otherNutrients: [WidgetNutrient] = NutrientID.allCases
//            .filter { $0 != .calories && $0 != .carbs && $0 != .protein && $0 != .totalFat && $0 != .other }
//            .map { WidgetNutrient(nutrientID: $0, color: .purple) }
//        
//        nutrients.append(contentsOf: otherNutrients)
//        
//        return nutrients
//    }()
//}
//
//struct WidgetNutrientQuery: EntityQuery {
//    func entities(for identifiers: [WidgetNutrient.ID]) async throws -> [WidgetNutrient] {
//        return WidgetNutrient.allNutrients.filter {
//            identifiers.contains($0.id)
//        }
//    }
//    
//    func suggestedEntities() async throws -> [WidgetNutrient] {
//        return WidgetNutrient.allNutrients
//    }
//    
//    func defaultResult() async -> WidgetNutrient? {
//        return WidgetNutrient.allNutrients.first
//    }
//}
//
//
//struct SingleMacroWidget: Widget {
//    let kind: String = "SingleMacroWidget"
//
//    var body: some WidgetConfiguration {
//        AppIntentConfiguration(kind: kind, intent: SelectNutrientIntent.self, provider: SingleMacroProvider()) { entry in
//            if #available(iOS 17.0, *) {
//                MacroSmallView(entry: entry)
//                    .containerBackground(.fill.tertiary, for: .widget)
//            } else {
//                MacroSmallView(entry: entry)
//                    .padding()
//                    .background()
//            }
//        }
//        .configurationDisplayName("Nutrient")  // shown in widget selector
//        .description("Display a single nutrient.")
//        .supportedFamilies([.systemSmall])
//    }
//}
//
//
////#Preview {
////    SingleMacroWidget()
////}
