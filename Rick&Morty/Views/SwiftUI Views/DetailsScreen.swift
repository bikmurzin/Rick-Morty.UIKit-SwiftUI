//
//  DetailsScreen.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 18.08.2023.
//

import SwiftUI

struct DetailsScreen: View {
    @State var sizeProportion: CGSize = .zero
    var referenceSize: CGSize = CGSize(width: 375, height: 812)
    var character: Personage
    let cornerRadius: CGFloat = 16
    @State var episodes: [Episode] = []
    @State var location: Location?
    var networkLayer = NetworkLayer()
    @State var isLoading: Bool = true
    var queue = DispatchQueue.global(qos: .userInteractive)
    var group = DispatchGroup()
    
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
                            OriginView(sizeProportion: sizeProportion, name: location?.name ?? "", type: location?.type ?? "")
                            EpisodesView(sizeProportion: sizeProportion, episodes: episodes)
                            
                            Spacer()
                        }
                        .task {
                            if let stringURL = character.origin?.url{
                                print("character.origin?.url: \(character.origin?.url)")
                                loadLocation(stringURL: stringURL)
                            }
                            if let urlArray = character.episode {
                                loadEpisodes(stringURLArray: urlArray)
                            }
                            group.notify(queue: queue) {
                                isLoading = false
                                print("Done")
                            }
                        }
                    }
                }
                .background(Color(red: 4/255, green: 13/255, blue: 30/255))
            }
            
            if isLoading {
                Loader()
            }
        }
    }
    
    func loadLocation(stringURL: String?) {
        print("Loading location...")
        guard let stringURL = stringURL else {
            print("Invalid URL")
            return
        }
        
        print("stringURL: \(stringURL)")
        let url = URL(string: stringURL)
        print("URL: \(url)")
        group.enter()
        queue.async {
            if stringURL.isEmpty {
                location = Location(id: 1, name: "Unknown", type: "Unknown")
                group.leave()
                return
            }
            networkLayer.loadData(url: url) { success, data in
                if success {
                    if let data = data {
                        networkLayer.dataTransformation(object: &location, data: data)
                    } else {
                        print("data is invalid")
                    }
                    print("Location loaded")
                    group.leave()
                } else {
                    print("Network request failed")
                    group.leave()
                }
            }
        }
    }
    
    func loadEpisodes(stringURLArray: [String?]) {
        print("Loading episodes...")
        for stringURL in stringURLArray {
            if let stringURL = stringURL {
                let url = URL(string: stringURL)
                group.enter()
                queue.async {
                    networkLayer.loadData(url: url) { success, data in
                        if success {
                            if let data = data {
                                var episode: Episode?// = Episode(id: 1, name: "", air_date: "", episode: "")
                                networkLayer.dataTransformation(object: &episode, data: data)
                                if let unwrEpisode = episode {
                                    episodes.append(unwrEpisode)
                                    print("Episode \(unwrEpisode.id) loaded")
                                }
                            }
                            
                            group.leave()
                        } else {
                            print("Network request failed")
                            group.leave()
                        }
                    }
                }
            }
        }
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen(character: Personage(id: 1))
    }
}
