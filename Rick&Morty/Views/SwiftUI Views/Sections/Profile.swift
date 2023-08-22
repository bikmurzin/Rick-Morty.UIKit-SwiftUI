//
//  Profile.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 21.08.2023.
//

import SwiftUI

struct Profile: View {
    var imageData: Data?
    var name: String?
    var status: String?
    var sizeProportion: CGSize
    var cornerRadius: CGFloat = 16
    
    var body: some View {
        VStack(spacing: 0){
            if let imageData = imageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 148 * sizeProportion.width, height: 148 * sizeProportion.width)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            } else {
                Image("NoImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 148 * sizeProportion.width, height: 148 * sizeProportion.width)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            }
            Text(name ?? "Name unknown")
                .foregroundColor(.white)
                .font(.system(size: 22))
                .bold()
                .padding(.top, 24 * sizeProportion.height)
            Text(status ?? "Status unknown")
                .foregroundColor(.green)
                .font(.system(size: 16))
                .padding(.top, 8 * sizeProportion.height)
        }
        .foregroundColor(Color(red: 71/255, green: 198/255, blue: 11/255))
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 4/255, green: 13/255, blue: 30/255)
                .ignoresSafeArea()
            Profile(name: "Rick Sanchez", status: "Alive", sizeProportion: CGSize(width: 1, height: 1))
        }
    }
}
