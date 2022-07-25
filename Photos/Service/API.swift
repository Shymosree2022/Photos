//
// API.swift
// Photos
//
//

import Foundation

struct API {
    
    func getPhotos(query: String, completion: @escaping ([PhotosModel])->()) {
        makeRequest(path: "photos", parameter: query, query:nil) { (data) in
            completion(TheDecoder.parsePhotos(data))
        }
    }
    
    func getSelectedPhoto(path: String, query: String?, completion: @escaping (SelectedPhotoModel)->()) {
        makeRequest(path: "photos/\(path)", parameter: nil, query:nil) { (data) in
            completion(TheDecoder.parseSelectedPhoto(data))
        }
    }
    
    private func makeRequest(path: String,parameter : String?, query : String?, completion: @escaping (Data)->()) {

        let urlString = "\(BASE_URL)" + "\(path)?" + "client_id=\(ACCESS_KEY)" + "&\(parameter ?? "")"
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                print("Invalid response or empty data")
                return
            }
            
            completion(data)
        }
        
        dataTask.resume()
    }
}

