//
//  UpMoviesTableViewCell.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 02/03/22.
//

import UIKit

class UpMoviesTableViewCell: UITableViewCell {

    static let upIdentifire = "UpMoviesTableViewCell"
    
    private let moviesTitleLable: UILabel = {
    let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let playMovieBtn: UIButton = {
        let playMovie = UIButton()
        let image = UIImage(systemName : "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        playMovie.setImage(image, for: .normal)
        playMovie.translatesAutoresizingMaskIntoConstraints = false
        playMovie.tintColor = .white
        return playMovie
    
    }()
    
    private let upMoivesPosterView : UIImageView = {
        let moviePoster = UIImageView()
        moviePoster.contentMode = .scaleAspectFill
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        moviePoster.clipsToBounds = true
        return moviePoster
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(upMoivesPosterView)
        contentView.addSubview(moviesTitleLable)
        contentView.addSubview(playMovieBtn)
        moviesConstraints()
    }
    
    private func moviesConstraints() {
        let moviesPosterConstraint = [
            upMoivesPosterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            upMoivesPosterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            upMoivesPosterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            upMoivesPosterView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let movieLableContraints = [
            moviesTitleLable.leadingAnchor.constraint(equalTo: upMoivesPosterView.trailingAnchor, constant: 20),
            moviesTitleLable.centerYAnchor.constraint(equalTo:  contentView.centerYAnchor)
        ]
        
        let playButtonContraints = [
            playMovieBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playMovieBtn.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(movieLableContraints)
        NSLayoutConstraint.activate(playButtonContraints)
        NSLayoutConstraint.activate(moviesPosterConstraint)

    }
    public func configure(with model : MovieViewModel){
        
        guard let imagePath = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        upMoivesPosterView.sd_setImage(with: imagePath, completed: nil)
        moviesTitleLable.text = model.movieName
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

}
