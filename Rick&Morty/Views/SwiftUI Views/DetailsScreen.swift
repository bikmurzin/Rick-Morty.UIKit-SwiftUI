//
//  DetailsScreen.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 18.08.2023.
//

import SwiftUI

struct DetailsScreen: View {
    @EnvironmentObject var detailsModel: DetailsModel
    @State var sizeProportion: CGSize = .zero
    var referenceSize: CGSize = CGSize(width: 375, height: 812)
    var character: Personage
    let cornerRadius: CGFloat = 16
    
    var body: some View {
        ZStack{
            GeometryReader { proxy in
                let size = proxy.size
                ScrollView(.vertical) {
                    ZStack {
                        Color(red: 4/255, green: 13/255, blue: 30/255)
                            .ignoresSafeArea()
                            .onAppear {
                                sizeProportion = CGSize(width: size.width / referenceSize.width,
                                                        height: size.height / referenceSize.height)
                            }
                        VStack(spacing: 24 * sizeProportion.height){
                            Profile(imageData: character.imageData, name: character.name, status: character.status, sizeProportion: sizeProportion)
                                .padding(.top, 16)
                            InfoView(sizeProportion: sizeProportion, species: character.species, type: character.type, gender: character.gender)
                            OriginView(sizeProportion: sizeProportion)
                            EpisodesView(sizeProportion: sizeProportion)
                        }
                        .task {                            
                            if let urlArray = character.episode {
                                detailsModel.getDetails(episodesURLs: urlArray, locationURL: character.origin?.url)
                            }
                        }
                    }
                }
                .background(Color(red: 4/255, green: 13/255, blue: 30/255))
            }
            if detailsModel.isLoading {
                Loader()
            }
        }
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen(character: Personage(id: 1))
            .environmentObject(DetailsModel())
    }
}
