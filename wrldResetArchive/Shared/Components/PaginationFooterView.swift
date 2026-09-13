import SwiftUI

struct PaginationFooterView: View {

    let isLoading: Bool
    let errorMessage: String?
    let retry: () async -> Void

    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .padding()
            } else if errorMessage != nil {
                VStack(spacing: 8) {
                    Text("No se pudieron cargar más publicaciones")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    Button("Reintentar") {
                        Task {
                            await retry()
                        }
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
        }
    }
}
