//
// PhotosModel.swift
// Photos
// 
//

import Foundation

struct PhotosModel: Codable {
    let id: String
    let createdAt, updatedAt: Date
    let promotedAt: Date?
    let width, height: Int
    let color, blurHash: String
    let welcomeDescription: String?
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case welcomeDescription = "description"
        case urls
    }
}


// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
