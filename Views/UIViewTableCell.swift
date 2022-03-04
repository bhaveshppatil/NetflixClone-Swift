//
//  UIViewTableCell.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 22/02/22.
//

import UIKit

protocol CollectionViewtableViewCellDel : AnyObject{
    func collectionViewCellDidTapCell (_ cell : UITableViewCell, viewModel : MoviePreviewViewModel)
    
}

class UIViewTableCell: UITableViewCell {

    weak var delegate : CollectionViewtableViewCellDel?
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = moviesCategoryTitle[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {return}
        
        APIService.shared.getMovieData(with: titleName + " trailer") { [weak self] results in
            switch results{
                case .success(let videoData):
                let title = self?.moviesCategoryTitle[indexPath.row]
                guard let titleOverview = title?.overview else { return }
                guard let strongSelf = self else {return}
                    
                let viewModel = MoviePreviewViewModel(title: titleName, youtubeView: videoData,
                                                      overview: titleOverview)
                    self?.delegate?.collectionViewCellDidTapCell(strongSelf, viewModel: viewModel)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
