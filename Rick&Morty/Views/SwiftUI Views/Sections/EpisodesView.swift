//
//  EPisodesView.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 22.08.2023.
//

import SwiftUI

struct EpisodesView: View {
    var sizeProportion: CGSize
    var episodes: [Episode]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16 * sizeProportion.height) {
            Text("Episodes")
                .foregroundColor(.white)
                .font(.system(size: 17))
                .bold()
                ForEach(episodes) { episode in
                    ZStack {
                        SectionBackgroundView(size: CGSize(width: 327 * sizeProportion.width, height: 86 * sizeProportion.height), cornerRadius: 16)
                        VStack(alignment: .leading, spacing: 16) {
                            Text(episode.name)
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                            HStack {
                                Text(episode.episode)
                                    .foregroundColor(Color(red: 71/255, green: 198/255, blue: 11/255))
                                    .font(.system(size: 13))
                                Spacer()
                                Text(episode.air_date)
                                    .foregroundColor(Color(red: 147/255, green: 152/255, blue: 156/255))
                                    .font(.system(size: 12))
                            }
                        }
                        .padding(.horizontal, 16 * sizeProportion.width)
                        
                    }
                    .frame(width: 327 * sizeProportion.width, height: 86 * sizeProportion.height)
                }
        }
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 4/255, green: 13/255, blue: 30/255)
                .ignoresSafeArea()
            EpisodesView(
                sizeProportion: CGSize(width: 1, height: 1),
                episodes: [
                    Episode(id: 1, name: "Pilot", air_date: "December 2, 2013", episode: "Episode: 1, Season: 1"),
                    Episode(id: 2, name: "Lawnmower Dog", air_date: "December 9, 2013", episode: "Episode: 2, Season: 1"),
                    Episode(id: 3, name: "Anatomy Park", air_date: "December 16, 2013", episode: "Episode: 3, Season: 1")
                ])
        }
    }
}
