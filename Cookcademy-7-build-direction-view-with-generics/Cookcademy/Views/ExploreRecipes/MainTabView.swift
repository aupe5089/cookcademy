//
//  MainTabView.swift
//  Cookcademy
//
//  Created by Austin Pearman on 12/11/23.
//

import SwiftUI

struct MainTabView: View {
    
    //Ensures that the object will persist if the view is redrawn
    @StateObject var recipeData = RecipeData()
    
    var body: some View {
        TabView {
            RecipeCategoryGridView()
                .tabItem {
                    Label("Recipes", systemImage: "list.dash")
                }
            NavigationView {
                RecipesListView(viewStyle: .favorites)
            }.tabItem { Label("Favorites", systemImage: "heart.fill")}
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .environmentObject(recipeData)
        //Gives access to recipeData to every subordinate view (no matter how deep) within the Tab View
        .onAppear {
            try! recipeData.loadRecipes()
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainTabView()
    }
}
