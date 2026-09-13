//
//  WrldresetAPIModels.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 30/08/2026.
//

import Foundation

nonisolated struct APIPage<T: Decodable & Sendable>: Decodable, Sendable {
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

nonisolated struct APIPageInfo: Decodable, Sendable {
    let size: Int
    let number: Int
    let totalElements: Int
    let totalPages: Int
}

nonisolated struct APIInstagramProfile: Decodable, Identifiable, Sendable {
    let id: String
    let username: String
    let displayName: String?
    let website: String?
    let privateAccount: Bool?
    let createdAt: Date?
    let updatedAt: Date?
}

nonisolated struct APIInstagramProfileSummary: Decodable, Sendable {
    let profileId: String
    let username: String
    let totalContents: Int
    let totalMediaItems: Int
    let contentsByType: [String: Int]

    func count(for type: APIInstagramContentType) -> Int {
        contentsByType[type.rawValue] ?? 0
    }
}

nonisolated struct APIInstagramContent: Decodable, Identifiable, Sendable {
    let id: String
    let contentType: APIInstagramContentType
    let title: String?
    let createdAtInstagram: Date?
    let mediaItems: [APIMediaItem]
}

nonisolated struct APIMediaItem: Decodable, Identifiable, Sendable {
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

nonisolated enum APIInstagramContentType: String, Decodable, Sendable {
    case post = "POST"
    case archivedPost = "ARCHIVED_POST"
    case reel = "REEL"
    case story = "STORY"
    case igtv = "IGTV"
    case profilePhoto = "PROFILE_PHOTO"
}

nonisolated enum APIMediaType: String, Decodable, Sendable {
    case image = "IMAGE"
    case video = "VIDEO"
    case subtitles = "SUBTITLE"
    case unknown = "UNKNOWN"
}
