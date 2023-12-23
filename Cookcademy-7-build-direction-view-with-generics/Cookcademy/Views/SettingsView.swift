//
//  SettingsView.swift
//  Cookcademy
//
//  Created by Austin Pearman on 12/11/23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    
    //For this, color just conform to RawRepresentable
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        NavigationView {
            Form {
                ColorPicker("List Background", selection: $listBackgroundColor)
                    .padding()
                    .listRowBackground(listBackgroundColor)
                Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
                    .padding()
                    .listRowBackground(listBackgroundColor)
                ColorPicker("Text Color", selection: $listTextColor)
                    .padding()
                    .listRowBackground(listBackgroundColor)
            }
            .foregroundColor(listTextColor)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
