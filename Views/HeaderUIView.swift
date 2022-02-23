//
//  HeaderUIView.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 22/02/22.
//

import UIKit

class HeaderUIView: UIView {
    
    private let btnPlay : UIButton = {
        
        let buttton = UIButton()
        buttton.setTitle("Play", for: .normal)
        buttton.layer.borderColor = UIColor.systemBackground.cgColor
        buttton.layer.borderWidth = 1
        buttton.translatesAutoresizingMaskIntoConstraints = false
        buttton.layer.cornerRadius = 10
        return buttton
    }()
    
    
    private let btnDownload : UIButton = {
        
        let buttton = UIButton()
        buttton.setTitle("Download", for: .normal)
        buttton.layer.borderColor = UIColor.systemBackground.cgColor
        buttton.layer.borderWidth = 1
        buttton.translatesAutoresizingMaskIntoConstraints = false
        buttton.layer.cornerRadius = 10
        return buttton
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "hector-reyes-PXjQaGxi4JA-unsplash")
        return imageView
    }()
    
    private func addGradients(){
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addGradients()
        addSubview(btnPlay)
        addSubview(btnDownload)
        applyConstraint()
    
    }
    
    private func applyConstraint(){
        let playButton = [
            btnPlay.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            btnPlay.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            btnPlay.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downlaodButton = [
            btnDownload.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            btnDownload.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            btnDownload.widthAnchor.constraint(equalToConstant: 100)
        ]
    
        NSLayoutConstraint.activate(playButton)
        NSLayoutConstraint.activate(downlaodButton)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}
