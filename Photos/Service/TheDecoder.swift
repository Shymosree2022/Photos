//
// TheDecoder.swift
// Photos
//
//

import Foundation

struct TheDecoder {
    static func parsePhotos(_ data: Data) -> [PhotosModel] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let results = try! decoder.decode([PhotosModel].self, from: data)
        
        return results
    }
    
    static func parseSelectedPhoto(_ data: Data) -> SelectedPhotoModel {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let results = try! decoder.decode(SelectedPhotoModel.self, from: data)
        
        return results
    }

}
