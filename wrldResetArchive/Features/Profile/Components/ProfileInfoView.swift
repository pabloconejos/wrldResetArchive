//
//  ProfileInfoView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct ProfileInfoView: View {

    let profile: APIInstagramProfile
    let summary: APIInstagramProfileSummary?

    var body: some View {
        HStack {
            profileImage

            Spacer()

            statistic(
                number: formattedCount(summary?.count(for: .post)),
                label: "Pubs"
            )

            Spacer()

            statistic(
                number: "-",
                label: "Seguidores"
            )

            Spacer()

            statistic(
                number: "-",
                label: "Siguiendo"
            )

            Spacer()
        }
        .padding()
    }

    private var profileImage: some View {
        Image(systemName: "person.crop.circle.fill")
            .resizable()
            .frame(width: 86, height: 86)
            .clipShape(Circle())
    }

    private func formattedCount(_ value: Int?) -> String {
        guard let value else {
            return "-"
        }

        return value.formatted()
    }

    private func statistic(number: String, label: String) -> some View {
        VStack {
            Text(number)
                .font(.headline)

            Text(label)
                .font(.caption)
        }
    }
}
