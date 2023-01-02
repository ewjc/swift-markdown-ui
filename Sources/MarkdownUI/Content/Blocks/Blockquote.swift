import Foundation

/// A markdown blockquote element.
///
/// Blockquote elements are typically used to quote text from another source.
///
/// ```swift
/// Markdown {
///   Blockquote {
///     Paragraph {
///       "Outside of a dog, a book is man's best friend."
///       "Inside of a dog, it's too dark to read."
///     }
///   }
///   Paragraph {
///     "– Groucho Marx"
///   }
/// }
/// ```
///
/// ![](BlockquoteContent)
public struct Blockquote: MarkdownContentProtocol {
  public var _markdownContent: MarkdownContent {
    .init(blocks: [.blockquote(content.blocks)])
  }

  private let content: MarkdownContent

  /// Creates a blockquote element that includes the specified markdown content.
  /// - Parameter content: A markdown content builder that returns the content included in the blockquote.
  public init(@MarkdownContentBuilder content: () -> MarkdownContent) {
    self.content = content()
  }
}
