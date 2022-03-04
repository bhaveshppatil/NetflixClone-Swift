//
//  MoviePreviewViewController.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 04/03/22.
//

import UIKit
import WebKit
class MoviePreviewViewController: UIViewController {

    private let webView : WKWebView = {
        let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()

    
    private let movielable : UILabel = {
        let lable = UILabel()
        lable.text = "Mission Impossible"
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 22, weight : .bold)
        return lable
        
    }()
    
    private let overviewlable : UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 22, weight : .regular)
        lable.text = "This is the best movie to watch as an adventure"
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.numberOfLines = 0
        return lable
    }()
    
    private let downloadButton : UIButton = {
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(movielable)
        view.addSubview(overviewlable)
        view.addSubview(downloadButton)
        
        constraints()
    }
    func constraints(){
        let webViewCon = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        let titleLableCon = [
            movielable.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            movielable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        let overviewLableCon = [
            overviewlable.topAnchor.constraint(equalTo: movielable.bottomAnchor, constant: 15),
            overviewlable.leadingAnchor.constraint(equalTo:  view.leadingAnchor, constant: 20),
            overviewlable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downlaodButtonCon = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),downloadButton.topAnchor.constraint(equalTo: overviewlable.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 150),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewCon)
        NSLayoutConstraint.activate(titleLableCon)
        NSLayoutConstraint.activate(overviewLableCon)
        NSLayoutConstraint.activate(downlaodButtonCon)
    }
    
    func configure(with  model : MoviePreviewViewModel){
        movielable.text = model.title
        overviewlable.text = model.overview
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {return}
        webView.load(URLRequest(url: url))
    }
}
