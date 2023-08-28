//
//  ContentView.swift
//  Task
//
//  Created by Jan Gulkowski on 28/08/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var coordinator = CoordinatorObject()
    
    var body: some View {
        CoordinatorView(object: coordinator)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
