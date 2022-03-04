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
    static let youtube_api = "AIzaSyCKvFjPPKbuzua9LYWeOGDXMfN_tfeFuPo"
    static let yt_base_url = "https://youtube.googleapis.com/youtube/v3/search?"
    
    // https://api.themoviedb.org/3/trending/all/day?api_key=b06d89e425a506ab8acb11d14584acea
    // https://api.themoviedb.org/3/trending/popular/day?api_key=b06d89e425a506ab8acb11d14584acea
    // https://api.themoviedb.org/3/movie/top_rated?api_key=b06d89e425a506ab8acb11d14584acea
    // https://api.themoviedb.org/3/movie/upcoming?api_key=b06d89e425a506ab8acb11d14584acea
    
}

enum APIResponseError : Error {
    case failed
}

class APIService {
    static let shared = APIService()
    
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
            guard let data = data, errror == nil else {return}
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIResponseError.failed))
            }
        }
        apiCall.resume()
    }
    
    func searchQuery(with query: String, completion : @escaping (Result<[MoviesTitle], Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.base_url)/3/search/movie?api_key=\(Constants.api_key)&query=\(query)") else {return}
        let apiCall = URLSession.shared.dataTask(with: URLRequest(url: url)) {
            data, _, errror  in
            guard let data = data, errror == nil else {return}
            do{
                let results = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch{
                completion(.failure(APIResponseError.failed))
            }
        }
        apiCall.resume()
    }
    
    func getMovieData(with query : String, completion : @escaping (Result<VideoData, Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.yt_base_url)q=\(query)&key=\(Constants.youtube_api)") else {return}
        let apiCall = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, errror  in
            guard let data = data, errror == nil else {return}
            do{
                let results = try JSONDecoder().decode(YTSearchResponse.self, from: data)
                completion(.success(results.items[0]))
            } catch{
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        apiCall.resume()
    }
}
