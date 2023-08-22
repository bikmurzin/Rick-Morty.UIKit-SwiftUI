//
//  sectionBackground.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 21.08.2023.
//

import SwiftUI

struct SectionBackgroundView: View {
    var size: CGSize
    var cornerRadius: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .foregroundColor(Color(red: 38/255, green: 42/255, blue: 57/255))
            .frame(width: size.width, height: size.height)
    }
}

struct sectionBackground_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(red: 4/255, green: 13/255, blue: 30/255)
                .ignoresSafeArea()
            SectionBackgroundView(size: CGSize(width: 327, height: 124), cornerRadius: 16)
        }
    }
}
