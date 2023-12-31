//
//  EPisodesView.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 22.08.2023.
//

import SwiftUI

struct EpisodesView: View {
    @EnvironmentObject var detailsModel: DetailsModel
    var sizeProportion: CGSize
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16 * sizeProportion.height) {
            Text("Episodes")
                .foregroundColor(.white)
                .font(.system(size: 17))
                .bold()
            
            ForEach(detailsModel.episodes) { episode in
                    ZStack {
                        SectionBackgroundView(size: CGSize(width: 327 * sizeProportion.width, height: 86 * sizeProportion.height), cornerRadius: 16)
                        VStack(alignment: .leading, spacing: 16) {
                            Text(episode.name)
                                .foregroundColor(.white)
                                .font(.system(size: 17))
                            HStack {
                                let numbers = episodeParsing(stringToParsing: episode.episode)
                                Text("Episode: \(numbers.1), Season: \(numbers.0)")
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
    
    func episodeParsing(stringToParsing: String) -> (Int, Int) {
        if let episodeIndex = stringToParsing.firstIndex(of: "E") {
            var seasonString = stringToParsing[..<episodeIndex]
            var episodeString = stringToParsing[episodeIndex...]
            seasonString.removeFirst()
            episodeString.removeFirst()
            if let unwrSeasonNumber = Int(seasonString),
               let unwrEpisodeNumber = Int(episodeString) {
                return (unwrSeasonNumber, unwrEpisodeNumber)
            }
        }
        return (0, 0)
    }
}

struct EpisodesView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 4/255, green: 13/255, blue: 30/255)
                .ignoresSafeArea()
            EpisodesView(sizeProportion: CGSize(width: 1, height: 1))
            .environmentObject(DetailsModel())
        }
    }
}
