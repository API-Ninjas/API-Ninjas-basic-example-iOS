//
//  Food.swift
//  NutritionViewer
//

import Foundation

struct Food: Codable, Identifiable {
    let id = UUID()
    var name: String
    var calories: Double
    var serving_size_g: Double
    var fat_total_g: Double
    var fat_saturated_g: Double
    var protein_g: Double
    var sodium_mg: Double
    var potassium_mg: Double
    var cholesterol_mg: Double
    var carbohydrates_total_g: Double
    var fiber_g: Double
    var sugar_g: Double
}

class Api : ObservableObject{
    @Published var foods = [Food]()
    
    func loadData(query: String, completion:@escaping ([Food]) -> ()) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/nutrition?query="+query!)!
        var request = URLRequest(url: url)
        request.setValue("YOUR_API_KEY", forHTTPHeaderField: "X-Api-Key")
        URLSession.shared.dataTask(with: request) { data, response, error in
            let foods = try! JSONDecoder().decode([Food].self, from: data!)
            print(foods)
            DispatchQueue.main.async {
                completion(foods)
            }
        }.resume()
    }
}
