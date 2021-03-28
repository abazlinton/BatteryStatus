//
//  YaApp.swift
//  Ya
//
//  Created by Alex Bazlinton on 17/03/2021.
//

import SwiftUI

@main
struct YaApp: App  {
    @NSApplicationDelegateAdaptor(ApplicationDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ApplicationDelegate.dataModel)
        }
    }
    
}


class DataModel : ObservableObject {
    @Published var duration: Int
    @Published var powerSource: String
    
    init(){
        self.duration = 0
        self.powerSource = "Yo"
    }
    
    func setDuration(_ newDuration: Int){
        self.duration = newDuration
    }
    
    
}

   
