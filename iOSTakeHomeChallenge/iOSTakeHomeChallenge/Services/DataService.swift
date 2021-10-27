//
//  DataService.swift
//  iOSTakeHomeChallenge
//
//  Created by dejaWorks on 27/10/2021.
//

import Foundation

public enum MyError:Error{
    case desc(String)
}

class DataService:NSObject {
    
    /**
     API endpoints
     */
    enum Endpoint{
        case books, houses, characters
        
        var string:String{
            switch self{
            case .books:return "books"
            case .characters:return "characters"
            case .houses:return "houses"
            }
        }
    }
    
    /**
     API Config
     */
    var baseUrlComponents:URLComponents {
        var uc = URLComponents()
        uc.scheme = "https"
        uc.host = "anapioficeandfire.com"
        uc.path = "/api/"
        return uc
    }
    
    
    // With enum
    func read(endpoint:Endpoint, _ completion: @escaping (Result<Data?, Error>)->Void){
        
        
        //guard let fullUrl = URL(string: baseUrl!.appendPathComponent(path, isDirectory: false))
        
        var uc = baseUrlComponents
        uc.path += endpoint.string
        
        guard let fullUrl = uc.url
        
        else { return completion(.failure(MyError.desc("fullUrl couldn't be created."))) }
        
        var request = URLRequest(url: fullUrl)
    
        
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            
            if let error = error{
                completion(.failure(error))
            }else{
                completion(.success(data))
            }
            
            
        })
        task.resume()
        
    }

    
    // with generics
    func getThe<T:ThroneData>(endpoint:Endpoint, dataType: T.Type, _ completion: @escaping (Result<[T], Error>)->Void) {
        DataService().read(endpoint: endpoint) { result in
            switch result{
            case .success(let data):
                if let data = data {
                    do{
                        let jsonObj = try JSONDecoder().decode([T].self, from: data)
                        completion(.success(jsonObj))
                    }catch{
                        print("📛 Error: \(error) \(#function) in\(self.description)")
                    }
                }else{
                    print("📛 data is NIL \(#function) in\(self.description)")
                }
                
            case .failure(let error):
                print("📛 Error: \(error) \(#function) in\(self.description)")
            }
        }
        
        
    }
    
    // with Generics
    func read(endpoint: String, _ completion: @escaping (Result<Data?, Error>)->Void){
        
        var uc = baseUrlComponents
        uc.path += endpoint
        
        guard let fullUrl = uc.url
        
        else { return completion(.failure(MyError.desc("fullUrl couldn't be created."))) }
        
        var request = URLRequest(url: fullUrl)
        
        
        request.httpMethod = "GET"
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.httpAdditionalHeaders = [
            "Content-Type": "application/json"
        ]
        let task = URLSession(configuration: config).dataTask(with: request, completionHandler: { (data, response, error) in
            
            if let error = error{
                completion(.failure(error))
            }else{
                completion(.success(data))
            }
            
            
        })
        task.resume()
        
    }
}
