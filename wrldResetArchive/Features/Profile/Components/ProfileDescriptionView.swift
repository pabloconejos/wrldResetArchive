//
//  ProfileDescriptionView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct ProfileDescriptionView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Make Europe Great Again")
                .font(.headline)

            Text("Mi archivo")
                .font(.subheadline)

            Text("Valencia")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}
