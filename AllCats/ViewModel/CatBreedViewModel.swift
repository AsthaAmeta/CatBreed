//
//  CatBreedViewModel.swift
//  AllCats
//
//  Created by Astha Ameta on 15/09/22.
//

import Foundation
import UIKit

protocol CatBreedDelegate {
    func didUpdateBreed(cat: [Cat])
}

class CatBreedViewModel: NSObject {
    var cat = [Cat]()
    var delegate: CatBreedDelegate?

    func getData(completion: @escaping () -> Void) {
        let url = "\(Constant.baseUrl)?api_key=\(Constant.api_key)"
        let urlString = URL(string: url)
        
        if let urlString = urlString {
            let task = URLSession.shared.dataTask(with: urlString) { data, response, error in
                if let error = error {
                    print(error)
                }
                if let data = data {
                    if let catData = self.parseJSON(data: data) {
                        self.delegate?.didUpdateBreed(cat: catData)
                        completion()
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> [Cat]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Cat].self, from: data)
            self.cat.append(contentsOf: decodedData)
            return decodedData
        }
        catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

extension UIImageView {
    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }).resume()
        }
    }
    
    func makeRounded() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
