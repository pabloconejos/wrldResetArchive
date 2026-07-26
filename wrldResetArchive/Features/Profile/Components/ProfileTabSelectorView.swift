//
//  ProfileTabSelectorView.swift
//  wrldResetArchive
//
//  Created by Pablo Conejos on 25/07/2026.
//

import SwiftUI

enum ProfileTab: Int, Equatable {
    case posts
    case videos
}

struct ProfileTabSelectorView: View {
    
    let posts: [InstagramPost]
    let repository: InstagramRepository

    @State private var selectedTab: ProfileTab = .posts // Esta vista tiene una variable que puede cambiar y cuando cambie SwiftUI debe volver a dibujar la vista.
    @Namespace private var tabIndicator // el namespace sirve para decir que estas dos posibles líneas representan realmente el mismo elemento visual.
    
    var body: some View {

        VStack(spacing: 0) {

            HStack {
                tabButton(icon: "square.grid.3x3", tab: .posts)
                tabButton(icon: "play.rectangle", tab: .videos)
            }
            
            TabView(selection: $selectedTab) {
                ProfilePostsGridView(
                    posts: posts,
                    repository: repository
                )
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )
                .tag(ProfileTab.posts)

                Text("Vídeos")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(ProfileTab.videos)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 650)

        }
    }
    
    private func tabButton(
        icon: String,
        tab: ProfileTab
    ) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.25)) {
                selectedTab = tab
            }
        } label: {
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(
                    selectedTab == tab
                        ? .primary
                        : .secondary
                )
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .overlay(alignment: .bottom) {
                    if selectedTab == tab {
                        Rectangle()
                            .frame(height: 2)
                            .matchedGeometryEffect(
                                id: "profileTabIndicator",
                                in: tabIndicator
                            )
                    }
                }
        }
        .buttonStyle(.plain)
    }

}

