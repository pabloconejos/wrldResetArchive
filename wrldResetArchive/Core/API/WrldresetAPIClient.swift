//
//  WrldresetAPIClient.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 30/08/2026.
//

import Foundation

struct WrldresetAPIClient {

    let configuration: WrldresetAPIConfiguration

    init(configuration: WrldresetAPIConfiguration = .development) {
        self.configuration = configuration
    }

    func fetchProfiles() async throws -> [APIInstagramProfile] {
        let url = configuration.baseURL.appending(path: "/api/profiles")
        return try await get(url)
    }
    
    func fetchProfileSummary(profileId: String) async throws -> APIInstagramProfileSummary {
        let url = configuration.baseURL.appending(path: "/api/profiles/\(profileId)/summary")
        return try await get(url)
    }

    func fetchContents(
        profileId: String,
        type: APIInstagramContentType? = nil,
        page: Int = 0,
        size: Int = 30
    ) async throws -> APIPage<APIInstagramContent> {
        var components = URLComponents(
            url: configuration.baseURL.appending(path: "/api/profiles/\(profileId)/contents"),
            resolvingAgainstBaseURL: false
        )

        var queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "size", value: String(size))
        ]

        if let type {
            queryItems.append(URLQueryItem(name: "type", value: type.rawValue))
        }

        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw URLError(.badURL)
        }

        return try await get(url)
    }

    func mediaURL(for mediaItem: APIMediaItem) -> URL {
        configuration.baseURL.appending(path: mediaItem.mediaUrl)
    }

    private func get<T: Decodable>(_ url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(T.self, from: data)
    }
}
