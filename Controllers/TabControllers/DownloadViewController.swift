//
//  DownloadViewController.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 21/02/22.
//

import UIKit

class DownloadViewController: UIViewController {

    private var movies : [ MovieItem] = [MovieItem]()

    private let downloadTable : UITableView = {
       let table = UITableView()
        table.register(UpMoviesTableViewCell.self, forCellReuseIdentifier: UpMoviesTableViewCell.upIdentifire)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Download Movies"
        view.addSubview(downloadTable)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        downloadTable.delegate = self
        downloadTable.dataSource = self
        fetchLocalDownloadData()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil){ _ in
            self.fetchLocalDownloadData()
        }
    }
    
    private func fetchLocalDownloadData(){
        DataManager.shared.fetchingMoviesFromDatabase { [weak self] result in
            switch result {
                case .success(let movie):
                    self?.movies = movie
                    DispatchQueue.main.async {
                        self?.downloadTable.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTable.frame = view.bounds
    }
}

extension DownloadViewController : UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
            case .delete :
            DataManager.shared.deleteMovie(model: movies[indexPath.row]) { [weak self] result in
                    switch result {
                        case .success():
                            print("Item deleted from the database")
                        case .failure(let error):
                            print(error)
                    }
                self?.movies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                }
            default :
                break;
        }
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
