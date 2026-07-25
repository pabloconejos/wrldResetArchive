//
//  ProfileHeaderView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI


struct ProfileHeaderView: View {
    var body: some View {
        HStack {
            Text("wrldreset")
                .font(.headline)

            Spacer()

            Button {
                print("Añadir")
            } label: {
                Image(systemName: "plus.app")
            }

            Button {
                print("Menú")
            } label: {
                Image(systemName: "line.3.horizontal")
            }
        }
        .padding()
    }
}
