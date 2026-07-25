//
//  ProfileButtons.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

struct ProfileActionButtonsView: View {
    var body: some View {
        HStack {
            Button {
                print("Edit Profile")
            } label: {
                Text("Edit Profile")
            }
            .buttonStyle(.bordered)
            .frame(maxWidth: .infinity)
            Button {
                print("Share Profile")
            } label: {
                Text("Share Profile")
            }
            .buttonStyle(.bordered)
            .frame(maxWidth: .infinity)
        }.padding(.horizontal)
    }
}
