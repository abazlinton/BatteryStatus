//
//  ContentView.swift
//  Ya
//
//  Created by Alex Bazlinton on 17/03/2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel : DataModel
    
    var body: some View {
        VStack {
            Text("Sleeping for \(dataModel.duration) seconds")
                .padding(10.0)
            Text(dataModel.powerSource)
                .padding(.bottom, 10.0)
        }.padding(10.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}



