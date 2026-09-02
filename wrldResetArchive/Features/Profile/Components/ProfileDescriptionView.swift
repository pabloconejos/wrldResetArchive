//
//  ProfileDescriptionView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct ProfileDescriptionView: View {

    let profile: APIInstagramProfile

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let displayName = profile.displayName {
                Text(displayName)
                    .font(.headline)
            }

            if let website = profile.website {
                Text(website)
                    .font(.subheadline)
                    .foregroundStyle(.blue)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
