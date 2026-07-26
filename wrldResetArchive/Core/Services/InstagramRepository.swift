//
//  InstagramRepository.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 26/07/2026.
//

import Foundation

struct InstagramRepository {

    let profiles: [InstagramProfile]
    let posts: [InstagramPost]

    func profile(withID id: String) -> InstagramProfile? {
        profiles.first { profile in
            profile.id == id
        }
    }
}
