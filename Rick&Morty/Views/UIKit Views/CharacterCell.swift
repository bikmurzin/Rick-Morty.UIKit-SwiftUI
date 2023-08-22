//
//  CharacterCell.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 18.08.2023.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    var characterNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        // Gilroy
        label.font = UIFont(name: "Arial", size: 17)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        backgroundColor = UIColor(red: 38/255, green: 42/255, blue: 57/255, alpha: 1)
        addSubview(characterImageView)
        addSubview(characterNameLabel)
        let width = frame.width
        let height = frame.height
        NSLayoutConstraint.activate([
            characterImageView.widthAnchor.constraint(equalToConstant: width * 0.897),
            characterImageView.heightAnchor.constraint(equalToConstant: width * 0.897),
            characterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: height * 0.039)
        ])
        NSLayoutConstraint.activate([
            characterNameLabel.heightAnchor.constraint(equalToConstant: 22),
            characterNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterNameLabel.widthAnchor.constraint(equalToConstant: width * 0.897),
            characterNameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: height * 0.079)
        ])
    }
}
