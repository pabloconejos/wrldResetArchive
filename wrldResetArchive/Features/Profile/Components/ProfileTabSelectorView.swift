import SwiftUI

enum ProfileTab: Int, Equatable {
    case posts
    case videos
}

struct ProfileTabSelectorView: View {

    let contents: [APIInstagramContent]
    let viewModel: RemoteProfileViewModel

    @State private var selectedTab: ProfileTab = .posts
    @Namespace private var tabIndicator

    private var postContents: [APIInstagramContent] {
        contents.filter { content in
            content.contentType == .post || content.contentType == .archivedPost
        }
    }

    private var videoContents: [APIInstagramContent] {
        contents.filter { content in
            content.contentType == .reel || content.contentType == .igtv
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            tabBar

            ProfilePostsGridView(
                contents: selectedContents,
                viewModel: viewModel
            )
        }
    }
    
    private var selectedContents: [APIInstagramContent] {
        switch selectedTab {
        case .posts:
            return postContents
        case .videos:
            return videoContents
        }
    }

    private var tabBar: some View {
        HStack {
            tabButton(icon: "square.grid.3x3", tab: .posts)
            tabButton(icon: "play.rectangle", tab: .videos)
        }
        .frame(height: 44)
    }

    private func tabButton(icon: String, tab: ProfileTab) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.25)) {
                selectedTab = tab
            }
        } label: {
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(selectedTab == tab ? .primary : .secondary)
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
