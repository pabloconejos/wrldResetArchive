//
//  PostHeaderView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 26/07/2026.
//

import SwiftUI

struct PostHeaderView: View {

    var body: some View {
        HStack(spacing: 10) {

            Image("2")
                .resizable()
                .scaledToFill()
                .frame(width: 34, height: 34)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text("pabloconejos")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text("Valencia")
                    .font(.caption)
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
