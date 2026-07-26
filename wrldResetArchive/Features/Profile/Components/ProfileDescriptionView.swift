//
//  ProfileDescriptionView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct ProfileDescriptionView: View {

    let profile: InstagramProfile

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            if let displayName = profile.displayName {
                Text(displayName)
                    .font(.headline)
            }

            if let biography = profile.biography {
                Text(biography)
                    .font(.subheadline)
            }

            if let location = profile.location {
                Text(location)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
