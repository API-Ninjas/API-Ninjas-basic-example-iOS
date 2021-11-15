//
//  ContentView.swift
//  NutritionViewer
//

import SwiftUI

struct ContentView: View {
    
    @State var foods = [Food]()
    @State var query: String = ""
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    func getNutrition() {
        Api().loadData(query: self.query) { (foods) in
            self.foods = foods
        }
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.vertical)
            .overlay(
                VStack(alignment: .leading) {
                    VStack {
                        TextField(
                            "Enter some food text",
                            text: $query
                        )
                        .multilineTextAlignment(.center)
                        .font(Font.title.weight(.light))
                        .foregroundColor(Color.white)
                        .padding()
                        HStack {
                            Spacer()
                            Button(action: getNutrition) {
                                Text("Get Nutrition")
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                            }
                            .font(.title2)
                            .foregroundColor(Color.white)
                            Spacer()
                        }
                    }
                    .padding(30.0)
                    List {
                        ForEach(foods) { food in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(food.name)")
                                        .font(.title)
                                        .padding(.bottom)
                                    Text("\(food.calories, specifier: "%.0f") calories")
                                        .font(.title2)
                                }
                                .minimumScaleFactor(0.01)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text("Serving Size: \(food.serving_size_g, specifier: "%.1f")g")
                                    Text("Total Fat: \(food.fat_total_g, specifier: "%.1f")g")
                                    Text("Saturated Fat: \(food.fat_saturated_g, specifier: "%.1f")g")
                                    Text("Protein: \(food.protein_g, specifier: "%.1f")g")
                                    Text("Sodium: \(food.sodium_mg, specifier: "%.1f")mg")
                                    Text("Potassium: \(food.potassium_mg, specifier: "%.1f")mg")
                                    Text("Cholesterol: \(food.cholesterol_mg, specifier: "%.1f")mg")
                                    Text("Carbohydrates: \(food.carbohydrates_total_g, specifier: "%.1f")g")
                                    Text("Fiber: \(food.fiber_g, specifier: "%.1f")g")
                                    Text("Sugar: \(food.sugar_g, specifier: "%.1f")g")
                                }
                                .minimumScaleFactor(0.01)
                                .font(.system(size: 18.0))
                            }
                            .listRowBackground(Color.clear)
                            .foregroundColor(.white)
                            .padding()
                        }
                    }
                }
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
