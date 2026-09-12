import SwiftUI

struct ProfileTabSelectorView: View {
    let contents: [APIInstagramContent]
    let viewModel: RemoteProfileViewModel

    private var fullContent: [APIInstagramContent] {
        contents.filter { content in
            content.contentType == .post || content.contentType == .reel
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            tabBar

            ProfilePostsGridView(
                contents: fullContent,
                viewModel: viewModel
            )
        }
    }

    private var tabBar: some View {
        Image(systemName: "square.grid.3x3")
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .overlay(alignment: .bottom) {
                Rectangle()
                    .frame(height: 2)
            }
            .accessibilityLabel("Publicaciones")
    }
}
