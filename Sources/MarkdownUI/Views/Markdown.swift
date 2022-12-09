import SwiftUI

public struct Markdown: View {
  private enum Storage: Equatable {
    case text(String)
    case markdownContent(MarkdownContent)

    var markdownContent: MarkdownContent {
      switch self {
      case .text(let markdown):
        return MarkdownContent(markdown)
      case .markdownContent(let markdownContent):
        return markdownContent
      }
    }
  }

  @Environment(\.theme.primary) private var primary
  @Environment(\.theme.secondary) private var secondary
  @Environment(\.theme.background) private var background
  @Environment(\.theme.font) private var font

  @State private var blocks: [Block] = []

  private let storage: Storage
  private let baseURL: URL?

  private init(storage: Storage, baseURL: URL?) {
    self.storage = storage
    self.baseURL = baseURL
  }

  public var body: some View {
    BlockSequence(self.blocks)
      .onAppear {
        // Delay markdown parsing until the view appears for the first time
        if self.blocks.isEmpty {
          self.blocks = self.storage.markdownContent.blocks
        }
      }
      .onChange(of: self.storage) { storage in
        self.blocks = storage.markdownContent.blocks
      }
      .environment(\.markdownBaseURL, self.baseURL)
      .foregroundStyle(self.primary, self.secondary)
      .background(self.background)
      .fontStyle(self.font)
  }
}

extension Markdown {
  public init(_ markdown: String, baseURL: URL? = nil) {
    self.init(storage: .text(markdown), baseURL: baseURL)
  }

  public init(baseURL: URL? = nil, @MarkdownContentBuilder content: () -> MarkdownContent) {
    self.init(storage: .markdownContent(content()), baseURL: baseURL)
  }
}
