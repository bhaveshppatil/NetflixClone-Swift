//
//  APiService.swift
//  NetflixClone-Swift
//
//  Created by Perennial Macbook on 23/02/22.
//

import Foundation

struct Constants {
    static let api_key = "b06d89e425a506ab8acb11d14584acea"
    static let base_url = "https://api.themoviedb.org"
    
    // https://api.themoviedb.org/3/trending/all/day?api_key=b06d89e425a506ab8acb11d14584acea
    // https://api.themoviedb.org/3/trending/popular/day?api_key=b06d89e425a506ab8acb11d14584acea
    // https://api.themoviedb.org/3/movie/top_rated?api_key=b06d89e425a506ab8acb11d14584acea
    // https://api.themoviedb.org/3/movie/upcoming?api_key=b06d89e425a506ab8acb11d14584acea
}

enum APIResponseError : Error {
    case failed
}

class APiService {
    static let shared = APiService()
    
    func getTrendingMovies(completion : @escaping (Result<[MoviesTitle], Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_url)/3/trending/movie/day?api_key=\(Constants.api_key)") else {return}
        let apiCall = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, errror  in
            guard let data = data, errror == nil else {
                return
            }

            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIResponseError.failed))
            }
        }
        apiCall.resume()
    }
    
    func getPopularMovies(completion : @escaping (Result<[MoviesTitle], Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_url)/3/movie/popular?api_key=\(Constants.api_key)") else {return}
        let apiCall = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, errror  in
            guard let data = data, errror == nil else {
                return
            }

            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIResponseError.failed))
            }
        }
        apiCall.resume()
    }
    
    func getTopRatedMovies(completion : @escaping (Result<[MoviesTitle], Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_url)/3/movie/top_rated?api_key=\(Constants.api_key)") else {return}
        let apiCall = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, errror  in
            guard let data = data, errror == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIResponseError.failed))
            }
        }
        apiCall.resume()
    }
    
    func getUpcomingMovies(completion : @escaping (Result<[MoviesTitle], Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_url)/3/movie/upcoming?api_key=\(Constants.api_key)") else {return}
        let apiCall = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, errror  in
            guard let data = data, errror == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIResponseError.failed))
            }
        }
        apiCall.resume()
    }
}
