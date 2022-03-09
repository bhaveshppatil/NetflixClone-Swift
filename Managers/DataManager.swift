//
//  DataManager.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 08/03/22.
//

import Foundation
import UIKit
import CoreData

class DataManager {
    
    enum DownloadError : Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDelegateData
    }
    static let shared = DataManager()
    
    func downloadMovie(model : MoviesTitle, completion : @escaping (Result<Void, Error>) -> Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = delegate.persistentContainer.viewContext
        
        let item = MovieItem(context: context)
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        
        do{
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DownloadError.failedToSaveData))
            print(error.localizedDescription)
        }
    }
    
    func fetchingMoviesFromDatabase (completion : @escaping (Result<[MovieItem], Error>) -> Void){
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = delegate.persistentContainer.viewContext
        let request: NSFetchRequest<MovieItem>
        request = MovieItem.fetchRequest()
        
        do {
            let movies = try context.fetch(request)
            completion(.success(movies))
            
        }catch {
            completion (.failure(DownloadError.failedToFetchData))
        }
    }
    
    func deleteMovie(model : MovieItem, completion : @escaping (Result<Void, Error>) -> Void){
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let context = delegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion (.failure(DownloadError.failedToDelegateData))
        }
    }
}
