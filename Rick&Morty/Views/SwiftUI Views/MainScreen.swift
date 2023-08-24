//
//  MainScreen.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 24.08.2023.
//

import SwiftUI

struct MainScreen: View {
    @StateObject var detailsModel = DetailsModel()
    var character: Personage
    
    var body: some View {
        DetailsScreen(character: character)
            .environmentObject(detailsModel)
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(character: Personage(id: 1))
    }
}
