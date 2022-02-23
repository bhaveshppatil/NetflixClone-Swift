//
//  HomeViewController.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 21/02/22.
//

import UIKit

class HomeViewController: UIViewController {

    let titles : [String] = ["Trending Movies", "Popular Movies", "Top Rated", "Upcoming Movies"]
    
    private let homeFeedTable : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UIViewTableCell.self, forCellReuseIdentifier: UIViewTableCell.identifire)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        navigationBar()
        
        let headerView = HeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        getTrendMovies()
    }
    
    private func navigationBar(){
        var image = UIImage(named: "netflix_logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,
                                                        style:.done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"),style: .done, target: self,action:nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"),style: .done,target:self, action: nil)
            ]
        navigationController?.navigationBar.tintColor = .white
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func getTrendMovies(){
        APiService.shared.getTrendingMovies { results in
            switch results {
                case .success(let movies) :
                    print(movies)
                case .failure(let error) :
                    print(error)
            }
        }
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)  -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UIViewTableCell.identifire, for: indexPath) as? UIViewTableCell else {
                return UITableViewCell()
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .bold)
            header.textLabel?.frame = CGRect(
                x: header.bounds.origin.x + 20,
                y: header.bounds.origin.y,
                width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
    }
}
