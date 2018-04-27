//
//  MarvelService.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 21/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import Foundation

class MarvelService {
    
    enum HttpRequestError: Error {
        case cantCreateUrlWithString
        case getRequestReturnedNilData
    }
    
    enum MarvelServiceError: Error {
        case statusCodeReturnedErrorCode(code: Int, status: String)
        case missingExpectedData
    }
    
    private let privateKey = "170ff3ab248ba262bf2c1c2bcb756b8a1fbc598b"
    private let publicKey = "c8ba6278a8341ed4ba9d129a86de68d5"
    
    func getHeroes(limit: Int, offset: Int, callback:@escaping (_ heroes: [Hero]?, _ error: Error?)->Void) {
        
        let urlString = baseUrlString(forEndpoint: "/characters", limit: limit, offset: offset)
        getHttpRequest(urlString: urlString, callback: { data, error in
            
            guard error == nil else {
                callback(nil, error)
                return
            }
            guard let data = data else {
                callback(nil, MarvelServiceError.missingExpectedData)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let characterDataWrapper = try decoder.decode(CharacterDataWrapper.self, from: data)
                guard characterDataWrapper.code == 200 else {
                    callback(nil, MarvelServiceError.statusCodeReturnedErrorCode(code: characterDataWrapper.code, status: characterDataWrapper.status))
                    return
                }
                guard let characterDataContainer = characterDataWrapper.data else {
                    callback(nil, MarvelServiceError.missingExpectedData)
                    return
                }
                guard let heroList = characterDataContainer.results else {
                    callback(nil, MarvelServiceError.missingExpectedData)
                    return
                }
                
                callback(heroList, nil)
            }
            catch {
                callback(nil, error)
            }
        })
    }
    
    private func createHash(uuid: UUID) -> String {
        return "\(uuid.uuidString)\(privateKey)\(publicKey)".md5()
    }
    
    private func baseUrlString(forEndpoint endpoint: String, limit: Int, offset: Int) -> String {
        let uuid = UUID()
        let hash = createHash(uuid: uuid)
        return "https://gateway.marvel.com/v1/public\(endpoint)?limit=\(limit)&offset=\(offset)&ts=\(uuid.uuidString)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    func getHttpRequest(urlString: String, callback:@escaping (_ data: Data?, _ error: Error?)->Void) {

        guard let requestUrl = URL(string: urlString) else{
            callback(nil, HttpRequestError.cantCreateUrlWithString)
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
        
            guard error == nil else {
                callback(nil, error)
                return
            }
            guard let data = data else {
                callback(nil, HttpRequestError.getRequestReturnedNilData)
                return
            }
            
            callback(data, nil)
        }
        task.resume()
    }
}
