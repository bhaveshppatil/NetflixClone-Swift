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
    private func downloadMovie(indexpath : IndexPath){
        DataManager.shared.downloadMovie(model: moviesCategoryTitle[indexpath.row]) { results in
            switch results {
                case .success():
                    NotificationCenter.default.post(name: NSNotification.Name("Downloaded"), object: nil)
                case .failure(let error):
                    print(error.localizedDescription)
            }
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
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] _ in
                let downlaod = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                    self?.downloadMovie(indexpath: indexPath)
                }
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline,
                              children: [downlaod])
            }
        return config
    }
    
}
