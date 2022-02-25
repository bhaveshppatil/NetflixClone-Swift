//
//  MoviesCollectionViewCell.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 24/02/22.
//

import UIKit
import SDWebImage

class MoviesCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "MoviesCollectionViewCell"
    //https://www.themoviedb.org/t/p/w1280/u80AJrwINGOeQElFd2fTOUaJyXY.jpg
    
    private let imageView : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    public func configure(with model : String){
        guard let imagePath = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
        imageView.sd_setImage(with: imagePath, completed: nil)
    }
}
