//
//  ProfileButtons.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct ProfileActionButtonsView: View {
    var body: some View {
        HStack(spacing: 8) {
            profileButton(title: "Edit Profile") {
                print("Edit Profile")
            }

            profileButton(title: "Share Profile") {
                print("Share Profile")
            }
        }
        .padding(.horizontal)
    }

    private func profileButton(
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .background(
                    .quaternary,
                    in: RoundedRectangle(cornerRadius: 8)
                )
        }
        .buttonStyle(.plain)
    }
}
