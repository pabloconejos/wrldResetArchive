//
//  ProfileInfoView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct ProfileInfoView: View {
    var body: some View {
        HStack(spacing: 24) {
            Image("profile _test")
                .resizable()
                .scaledToFill()
                .frame(width: 72, height: 72)
                .clipShape(Circle())

            Spacer()

            HStack(spacing: 24) {
                statistic(number: "4652", label: "Pubs")
                statistic(number: "812", label: "Seg")
                statistic(number: "430", label: "Siguiendo")
            }
        }
        .padding(.horizontal)
    }

    private func statistic(number: String, label: String) -> some View {
        VStack(spacing: 2) {
            Text(number)
                .font(.headline)

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(minWidth: 52)
    }
}
