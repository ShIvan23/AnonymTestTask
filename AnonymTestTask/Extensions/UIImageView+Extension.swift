//
//  UIImageView+Extension.swift
//  AnonymTestTask
//
//  Created by Ivan on 03.06.2021.
//

import UIKit

extension UIImageView {
    
    /// Загрузка изображения. Сперва происходит проверка наличия изображения в кеше. В случае, если в кеше его нет, происходит загрузка из сети.
    func loadImage(by url: URL, completion: (() -> Void)? = nil) {
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if let imageData = cache.cachedResponse(for: request)?.data {
            image = UIImage(data: imageData)
            completion?()
        } else {
            URLSession.shared.dataTask(with: request) { [weak self] data, response, _ in
                defer {
                    completion?()
                }
                
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    guard let data = data, let response = response else { return }
                    
                    let cacheRepsonse = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cacheRepsonse, for: request)
                    self.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
