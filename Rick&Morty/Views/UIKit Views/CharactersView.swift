//
//  CharactersCollectionView.swift
//  Rick&Morty
//
//  Created by Robert Bikmurzin on 18.08.2023.
//

import UIKit
import SwiftUI

class CharactersView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var isBottomReached = false
    var width: CGFloat = 0
    var height: CGFloat = 0
    weak var delegate: ViewControllerDelegateForCharactersView?
    var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "Arial", size: 28)
        label.text = "Characters"
        return label
    }()
    var characters: Characters?
    // Идентификатор ячейки
    let cellId = "CharacterCell"
    // Инициализация collectionView
    let charactersCollectionView: UICollectionView = {
        // Инициализация layout
        let layout = UICollectionViewFlowLayout()
        // Установка вертикального направления
        layout.scrollDirection = .vertical
        // Расстояние между строками collectionView
        layout.minimumLineSpacing = 16
        // Создаем объект Collection View с указанными frame и layout
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // активация constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 4/255, green: 13/255, blue: 30/255, alpha: 1)
        return collectionView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        addSubview(charactersCollectionView)
        charactersCollectionView.delegate = self
        charactersCollectionView.dataSource = self
        height = self.bounds.height
        width = self.bounds.width
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            charactersCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: height * 0.165),
            charactersCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            charactersCollectionView.widthAnchor.constraint(equalToConstant: width * 0.875),
            charactersCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        charactersCollectionView.register(CharacterCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Размеры ячеек в collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: width * 0.416, height: height * 0.248)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let delegate = delegate else {return 0}
        characters = delegate.getCharacters()
        guard let characters = characters else {return 0}
        return characters.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = charactersCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CharacterCell
        guard let characters = characters,
              let imageData = characters.results[indexPath.row].imageData,
              let name = characters.results[indexPath.row].name else {return cell}
        cell.characterImageView.image = UIImage(data: imageData)
        cell.characterNameLabel.text = name
        cell.layer.cornerRadius = 16
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // дошли до конца scrollView
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) && !isBottomReached) {
            print("bottom")
            isBottomReached = true
            delegate?.loadMoreCharacters()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let character = characters?.results[indexPath.row] else {return}
        delegate?.showDetailView(character: character)
        print("character: \(character.origin)")
    }
}
