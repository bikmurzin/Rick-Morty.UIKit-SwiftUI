//
//  Loader.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 21.08.2023.
//

import SwiftUI

struct Loader: View {
    var width: CGFloat = 375
    var height: CGFloat = 800
    
    var body: some View {
        ZStack {
            Rectangle()
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .foregroundColor(Color(white: 0, opacity: 0.7))
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(1.74)
                .progressViewStyle(CircularProgressViewStyle(tint: Color(red: 1, green: 1, blue: 1)))
        }
    }
}

struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
