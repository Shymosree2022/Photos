//
// SelectedPhotoModel.swift
// Photos
//
//

import Foundation

struct SelectedPhotoModel: Codable {
    let id: String
    let createdAt, updatedAt: Date
    let width, height: Int
    let color, blurHash: String
    let urls: Urls

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color
        case blurHash = "blur_hash"
        case urls
    }
}

// MARK: - Exif
struct Exif: Codable {
    let make, model, name, exposureTime: String
    let aperture, focalLength: String
    let iso: Int

    enum CodingKeys: String, CodingKey {
        case make, model, name
        case exposureTime = "exposure_time"
        case aperture
        case focalLength = "focal_length"
        case iso
    }
}

// MARK: - SelectedPhotoLinks
struct SelectedPhotoLinks: Codable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

