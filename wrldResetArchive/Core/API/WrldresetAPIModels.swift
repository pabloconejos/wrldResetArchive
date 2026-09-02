//
//  WrldresetAPIModels.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 30/08/2026.
//

import Foundation

struct APIPage<T: Decodable>: Decodable {
    let content: [T]
    let page: APIPageInfo

    enum CodingKeys: String, CodingKey {
        case content
        case page
        case size
        case number
        case totalElements
        case totalPages
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        content = try container.decode([T].self, forKey: .content)

        if let nestedPage = try? container.decode(APIPageInfo.self, forKey: .page) {
            page = nestedPage
        } else {
            page = APIPageInfo(
                size: try container.decode(Int.self, forKey: .size),
                number: try container.decode(Int.self, forKey: .number),
                totalElements: try container.decode(Int.self, forKey: .totalElements),
                totalPages: try container.decode(Int.self, forKey: .totalPages)
            )
        }
    }
}

struct APIPageInfo: Decodable {
    let size: Int
    let number: Int
    let totalElements: Int
    let totalPages: Int
}

struct APIInstagramProfile: Decodable, Identifiable {
    let id: String
    let username: String
    let displayName: String?
    let website: String?
    let privateAccount: Bool?
    let createdAt: Date?
    let updatedAt: Date?
}

struct APIInstagramProfileSummary: Decodable {
    let profileId: String
    let username: String
    let totalContents: Int
    let totalMediaItems: Int
    let contentsByType: [String: Int]

    func count(for type: APIInstagramContentType) -> Int {
        contentsByType[type.rawValue] ?? 0
    }
}

struct APIInstagramContent: Decodable, Identifiable {
    let id: String
    let contentType: APIInstagramContentType
    let title: String?
    let createdAtInstagram: Date?
    let mediaItems: [APIMediaItem]
}

struct APIMediaItem: Decodable, Identifiable {
    let id: String
    let position: Int
    let mediaType: APIMediaType
    let storagePath: String
    let mediaUrl: String
    let fileName: String
    let mimeType: String
    let sizeBytes: Int?
    let createdAtInstagram: Date?
}

enum APIInstagramContentType: String, Decodable {
    case post = "POST"
    case archivedPost = "ARCHIVED_POST"
    case reel = "REEL"
    case story = "STORY"
    case igtv = "IGTV"
    case profilePhoto = "PROFILE_PHOTO"
}

enum APIMediaType: String, Decodable {
    case image = "IMAGE"
    case video = "VIDEO"
    case subtitles = "SUBTITLE"
    case unknown = "UNKNOWN"
}
