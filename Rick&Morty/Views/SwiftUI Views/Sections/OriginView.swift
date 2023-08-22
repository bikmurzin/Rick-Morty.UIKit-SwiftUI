//
//  OriginView.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 21.08.2023.
//

import SwiftUI

struct OriginView: View {
    var sizeProportion: CGSize
    var name: String?
    var type: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16 * sizeProportion.height) {
            Text("Origin")
                .foregroundColor(.white)
                .font(.system(size: 17))
                .bold()
            
            ZStack {
                SectionBackgroundView(size: CGSize(width: 327 * sizeProportion.width, height: 80 * sizeProportion.height), cornerRadius: 16)
                HStack(spacing: 16 * sizeProportion.width) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(red: 25/255, green: 28/255, blue: 42/255))
                        Image("planet")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                    .frame(width: 64 * sizeProportion.width, height: 64 * sizeProportion.width)
                    .padding(.leading, 8)
                    
                    VStack(alignment: .leading, spacing: 8 * sizeProportion.height) {
                        Text(name ?? "None")
                            .foregroundColor(.white)
                            .font(.system(size: 17))
                            .bold()
                        Text(type ?? "None")
                            .foregroundColor(Color(red: 71/255, green: 198/255, blue: 11/255))
                            .font(.system(size: 13))
                    }
                    Spacer()
                }
            }
            .frame(width: 327 * sizeProportion.width, height: 80 * sizeProportion.height)
        }
    }
}

struct OriginView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 4/255, green: 13/255, blue: 30/255)
                .ignoresSafeArea()
            OriginView(sizeProportion: CGSize(width: 1, height: 1), name: "Earth", type: "Planet")
        }
    }
}
