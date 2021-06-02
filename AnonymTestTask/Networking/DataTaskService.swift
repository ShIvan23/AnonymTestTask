//
//  DataTaskService.swift
//  AnonymTestTask
//
//  Created by Ivan on 02.06.2021.
//

import Foundation

typealias JSONTask = URLSessionTask
typealias JSONCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void

protocol DataTaskServiceProtocol {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    func fetch<T: Decodable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void)
}

final class DataTaskService: DataTaskServiceProtocol {
    
    // MARK: - Public Properties
    
    private(set) var sessionConfiguration: URLSessionConfiguration
    
    private(set) lazy var session: URLSession = {
        URLSession(configuration: self.sessionConfiguration)
    }()
    
    // MARK: - Initializers
    
    init(sessionConfiguration: URLSessionConfiguration) {
        self.sessionConfiguration = sessionConfiguration
    }
    
    convenience init() {
        self.init(sessionConfiguration: URLSessionConfiguration.default)
    }
    
    // MARK: - Public Methods
    
    func fetch<T: Decodable>(request: URLRequest, completionHandler: @escaping (Result<T, Error>) -> Void) {
        
        let dataTask = JSONTask(request: request) { [weak self] data, _, error in
            
            DispatchQueue.main.async {
                guard let data = data else {
                    if let error = error {
                        completionHandler(.failure(error))
                    }
                    return
                }
                
                if let value = self?.decodeJSON(type: T.self, from: data) {
                    completionHandler(.success(value))
                } else {
                    let error = NSError()
                    completionHandler(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    // MARK: - Private Methods
    
    private func JSONTask(request: URLRequest, completionHandler: @escaping JSONCompletionHandler) -> JSONTask {
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let error = error
                completionHandler(nil, nil, error)
                return
            }
            
            switch HTTPResponse.statusCode {
            case 200:
                completionHandler(data, HTTPResponse, nil)
            default:
                completionHandler(nil, HTTPResponse, error)
            }
        }
        return dataTask
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        
        let decoder = JSONDecoder()
        
        guard let data = from else { return nil }
        
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        }
        
        catch DecodingError.dataCorrupted(let context) {
            print(DecodingError.dataCorrupted(context))
        } catch DecodingError.keyNotFound(let key, let context) {
            print(DecodingError.keyNotFound(key,context))
        } catch DecodingError.typeMismatch(let type, let context) {
            print(DecodingError.typeMismatch(type,context))
        } catch DecodingError.valueNotFound(let value, let context) {
            print(DecodingError.valueNotFound(value,context))
        } catch let error{
            print(error)
        }
        return nil
    }
}
