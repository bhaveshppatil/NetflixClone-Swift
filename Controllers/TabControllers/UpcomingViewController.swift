//
//  UpcomingViewController.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 21/02/22.
//

import UIKit
import MapKit

class UpcomingViewController: UIViewController {

    private var movies : [MoviesTitle] = [MoviesTitle]()
    
    private let upcomingTable : UITableView = {
       let table = UITableView()
        table.register(UpMoviesTableViewCell.self, forCellReuseIdentifier: UpMoviesTableViewCell.upIdentifire)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        getUpcoingMoviesData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func getUpcoingMoviesData(){
        APIService.shared.getUpcomingMovies { [weak self] results in
            switch results {
                case .success(let movies):
                    self?.movies = movies
                    DispatchQueue.main.async {
                        self?.upcomingTable.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpMoviesTableViewCell.upIdentifire, for: indexPath) as? UpMoviesTableViewCell else {
            return UITableViewCell()
        }
        let title = movies[indexPath.row]
        cell.configure(with: MovieViewModel(movieName: title.original_title ?? "Unknown Name", posterURL: title.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        guard let movieName = movie.original_title ?? movie.original_name else {
            return
        }
        
        APIService.shared.getMovieData(with: movieName) { [weak self] results in
            switch results {
                case .success(let videoEle):
                    DispatchQueue.main.async {
                        let vc = MoviePreviewViewController()
                        vc.configure(with: MoviePreviewViewModel(title: movieName, youtubeView: videoEle, overview: movie.overview ?? ""))
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
