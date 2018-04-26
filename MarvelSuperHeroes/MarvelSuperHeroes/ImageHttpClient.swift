//
//  ImageHttpClient.swift
//  MarvelSuperHeroes
//
//  Created by Thaciana Lima on 25/04/18.
//  Copyright © 2018 TL. All rights reserved.
//

import UIKit

class ImageHttpClient: NSObject {
    
    static let shared = ImageHttpClient()
    
    var session: URLSession!
    
    private override init() {
        super.init()
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
    
    func getImage(urlString: String, callback:@escaping (_ image: UIImage?, _ error: Error?)->Void) {
        
        guard let requestUrl = URL(string: urlString) else{
            return
        }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"

        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            guard error == nil else {
                callback(nil, error)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                callback(image, nil)
            }
        }
        task.resume()
    }
}

extension ImageHttpClient: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        completionHandler(proposedResponse)
    }
}

