//
//  SearchResultsViewController.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 03/03/22.
//

import UIKit


protocol SearchResultsViewControllerDel : AnyObject {
    func searchResultsViewOnItemTap(_ viewModel : MoviePreviewViewModel)
}
class SearchResultsViewController: UIViewController {

    public var movies :[MoviesTitle] = [MoviesTitle]()
    public weak var delegate : SearchResultsViewControllerDel?
    
    public let searchResultsView : UICollectionView  = {
         let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.identifire)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsView)
    
        searchResultsView.delegate = self
        searchResultsView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsView.frame = view.bounds
    }
}

extension SearchResultsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifire, for: indexPath) as? MoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        let title = movies[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        let movieName = movie.original_name ?? ""
        let movieOverview = movie.overview ?? ""

        APIService.shared.getMovieData(with: movieName) { [weak self] results in
            switch results {
                case .success(let data):
                    self?.delegate?.searchResultsViewOnItemTap(MoviePreviewViewModel(
                    title: movieName,
                    youtubeView: data, overview: movieOverview))
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
