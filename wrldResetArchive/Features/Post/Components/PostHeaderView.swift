//
//  PostHeaderView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 26/07/2026.
//

import SwiftUI

struct PostHeaderView: View {

    let profile: InstagramProfile

    var body: some View {
        HStack(spacing: 10) {

            if let profileImageName = profile.profileImageName {
                Image(profileImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 34, height: 34)
                    .clipShape(Circle())
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(profile.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                if let location = profile.location {
                    Text(location)
                        .font(.caption)
                }
            }

            Spacer()

            Button {
                // Más opciones
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.primary)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}
