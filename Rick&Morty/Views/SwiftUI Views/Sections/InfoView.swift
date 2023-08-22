//
//  Info.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 21.08.2023.
//

import SwiftUI

struct InfoView: View {
    var sizeProportion: CGSize
    var species: String?
    var type: String?
    var gender: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16 * sizeProportion.height) {
            Text("Info")
                .foregroundColor(.white)
                .font(.system(size: 17))
                .bold()
            ZStack {
                SectionBackgroundView(size: CGSize(width: 327 * sizeProportion.width, height: 124 * sizeProportion.height), cornerRadius: 16)
                HStack {
                    VStack(alignment: .leading, spacing: 16 * sizeProportion.height) {
                        Text("Species")
                        Text("Type")
                        Text("Gender")
                    }
                    .foregroundColor(Color(red: 196/255, green: 201/255, blue: 206/255))
                    Spacer()
                    VStack(alignment: .trailing, spacing: 16 * sizeProportion.height) {
                        if let species = species {
                            Text(!species.isEmpty ? species : "None")
                        }
                        if let type = type {
                            Text(!type.isEmpty ? type : "None")
                        }
                        if let gender = gender {
                            Text(!gender.isEmpty ? gender : "None")
                        }
                    }
                    .foregroundColor(.white)
                }
                .font(.system(size: 16))
                .padding(.horizontal, 16)
            }
            .frame(width: 327 * sizeProportion.width, height: 124 * sizeProportion.height)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 4/255, green: 13/255, blue: 30/255)
                .ignoresSafeArea()
            InfoView(sizeProportion: CGSize(width: 1, height: 1), species: "Human", type: "None", gender: "Male")
        }
    }
}
