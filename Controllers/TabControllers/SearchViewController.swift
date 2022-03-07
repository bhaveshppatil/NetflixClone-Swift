//
//  SearchViewController.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 21/02/22.
//

import UIKit

class SearchViewController: UIViewController {

    public var movies : [MoviesTitle] = [MoviesTitle]()
    
    private let topSearchViewTable : UITableView = {
       let table = UITableView()
        table.register(TopMoviesTableViewCell.self, forCellReuseIdentifier: TopMoviesTableViewCell.topIdentifire)
        return table
    }()
    
    private let searchMovieView : UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search movie here"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Top Searches"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchMovieView
        navigationController?.navigationBar.tintColor = .white
        view.addSubview(topSearchViewTable)
        topSearchViewTable.delegate = self
        topSearchViewTable.dataSource = self
        
        getTopSearchMoviesData()
        
        searchMovieView.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topSearchViewTable.frame = view.bounds
    }
    
    private func getTopSearchMoviesData(){
        APIService.shared.getTopRatedMovies { [weak self] results in
            switch results {
                case .success(let movies):
                    self?.movies = movies
                    DispatchQueue.main.async {
                        self?.topSearchViewTable.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TopMoviesTableViewCell.topIdentifire, for: indexPath) as?TopMoviesTableViewCell else {
            return UITableViewCell()
        }
        let title = movies[indexPath.row]
        cell.configure(with: MovieViewModel(movieName: title.original_title ?? "Unknown Name", posterURL: title.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {return}
        
        APIService.shared.searchQuery(with: query) { result in
            DispatchQueue.main.async {
                switch result{
                    case .success(let titles):
                        resultsController.movies = titles
                        resultsController.searchResultsView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
}
