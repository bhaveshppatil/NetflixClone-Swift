//
//  TopMoviesTableViewCell.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 02/03/22.
//

import UIKit

class TopMoviesTableViewCell: UITableViewCell {

    static let topIdentifire = "TopMoviesTableViewCell"
    
    private let movieTitle: UILabel = {
    let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let moviePlayButton: UIButton = {
        let playMovie = UIButton()
        let image = UIImage(systemName : "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        playMovie.setImage(image, for: .normal)
        playMovie.translatesAutoresizingMaskIntoConstraints = false
        playMovie.tintColor = .white
        return playMovie
    
    }()
    
    private let topMoviesPosterView : UIImageView = {
        let moviePoster = UIImageView()
        moviePoster.contentMode = .scaleAspectFill
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        moviePoster.clipsToBounds = true
        return moviePoster
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(topMoviesPosterView)
        contentView.addSubview(movieTitle)
        contentView.addSubview(moviePlayButton)
        topMoviesConstraints()
    }
    
    private func topMoviesConstraints() {
        let moviesPosterConstraint = [
            topMoviesPosterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topMoviesPosterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            topMoviesPosterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            topMoviesPosterView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let movieLableContraints = [
            movieTitle.leadingAnchor.constraint(equalTo: topMoviesPosterView.trailingAnchor, constant: 20),
            movieTitle.centerYAnchor.constraint(equalTo:  contentView.centerYAnchor)
        ]
        
        let playButtonContraints = [
            moviePlayButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            moviePlayButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(movieLableContraints)
        NSLayoutConstraint.activate(playButtonContraints)
        NSLayoutConstraint.activate(moviesPosterConstraint)

    }
    
    public func configure(with model : TopSearchViewModel){
        
        guard let imagePath = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        topMoviesPosterView.sd_setImage(with: imagePath, completed: nil)
        movieTitle.text = model.movieName
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
