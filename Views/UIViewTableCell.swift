//
//  UIViewTableCell.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 22/02/22.
//

import UIKit

class UIViewTableCell: UITableViewCell {

    static let identifire = "UIViewTableCell"
    private var moviesCategoryTitle : [MoviesTitle] = [MoviesTitle]()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MoviesCollectionViewCell.self,forCellWithReuseIdentifier: MoviesCollectionViewCell.identifire)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    public func configure(with movieTitle:[MoviesTitle]){
        self.moviesCategoryTitle = movieTitle
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension UIViewTableCell : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifire, for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = moviesCategoryTitle[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesCategoryTitle.count
    }
}
