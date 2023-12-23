//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Ben Stone on 4/19/21.
//

import Foundation

class RecipeData: ObservableObject {
    //needs to conform to observable object to be passed into the environment.
    
    @Published var recipes = Recipe.testRecipes
    
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        return filteredRecipes
    }
    
    func add(recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
            try! saveRecipes()
        }
    }
    
    func index(of recipe: Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
                return i
            }
        }
        return nil
    }
    
    var favoriteRecipes: [Recipe] {
        recipes.filter { $0.isFavorite }
    }
    
    func saveRecipes() throws {
        do {
            let encodeData = try JSONEncoder().encode(recipes)
            try encodeData.write(to: recipesFileURL)
        } catch {
            fatalError("Could not save recipe: \(error)")
        }
    }
    
    func loadRecipes() throws {
        guard let data = try? Data(contentsOf: recipesFileURL) else { return }
        do {
            let savedRecipes = try JSONDecoder().decode([Recipe].self, from: data)
            recipes = savedRecipes
        } catch {
            fatalError("Could not load recipes: \(error)")
        }
    }
    
    private var recipesFileURL: URL {
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            return documentsDirectory
        } catch {
            fatalError("An error occured when getting the url: \(error)")
        }
    }
}
