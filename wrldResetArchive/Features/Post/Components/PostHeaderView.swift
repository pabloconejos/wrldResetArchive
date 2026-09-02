//
//  PostHeaderView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 26/07/2026.
//

import SwiftUI

struct PostHeaderView: View {

    let profile: APIInstagramProfile
    
    var body: some View {
        HStack(spacing: 10) {
            profileImage

            VStack(alignment: .leading, spacing: 2) {
                Text(profile.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                if let displayName = profile.displayName {
                    Text(displayName)
                        .font(.caption)
                        .foregroundStyle(.secondary)
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

    @ViewBuilder
    private var profileImage: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 34, height: 34)
            .foregroundStyle(.secondary)
    }
}
