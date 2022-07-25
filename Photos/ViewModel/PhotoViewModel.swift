//
// PhotoViewModel.swift
// Photos
//
//

import UIKit

class PhotoViewModel: NSObject {
    var photoListBinding:(([PhotosModel]?, Bool) -> Void)?
    var photoList : [PhotosModel] = [PhotosModel]()
    var selectedPhoto : SelectedPhotoModel!
    var configurationUrl : String?
    var configurationPosterSize : String?
    let api = API()
    
    func fetchData (param : String) {
        api.getPhotos(query: param, completion: { result in
            print("Done🔨\(result)")
            self.photoList = result
            if let photoListBinding = self.photoListBinding {
                photoListBinding(self.photoList, true)
            }
        })
    }
    
    func getSelectedPhoto (photoId : String, completion: @escaping (SelectedPhotoModel)->()) {
        api.getSelectedPhoto(path: photoId, query: nil, completion:{ result in
            print("Done🔨\(result)")
            self.selectedPhoto = result
            completion(self.selectedPhoto)
        })
    }
}

