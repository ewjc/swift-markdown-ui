@_exported import CommonMark
import SwiftUI

/// A view that displays Markdown formatted text.
///
/// A Markdown view displays formatted text using the Markdown syntax, fully compliant
/// with the [CommonMark Spec](https://spec.commonmark.org/current/).
///
///     Markdown("It's very easy to make some words **bold** and other words *italic* with Markdown.")
///
/// A Markdown view renders text using a `body` font appropriate for the current platform.
/// You can choose a different font or customize other properties like the foreground color,
/// code font, or heading font sizes using the `markdownStyle(_:)` view modifier.
///
///     Markdown("If you have inline code blocks, wrap them in backticks: `var example = true`.")
///         .markdownStyle(
///             DefaultMarkdownStyle(
///                 font: .custom("Helvetica Neue", size: 14),
///                 foregroundColor: .gray
///                 codeFontName: "Menlo"
///             )
///         )
///
/// Use the `accentColor(_:)` view modifier to configure the link color.
///
///     Markdown("Play with the [reference CommonMark implementation](https://spec.commonmark.org/dingus/).")
///         .accentColor(.purple)
///
/// A Markdown view always uses all the available width and adjusts its height to fit its
/// rendered text.
///
/// Use modifiers like `lineLimit(_:)`  and `truncationMode(_:)` to configure
/// how the view handles space constraints.
///
///     Markdown("> Knowledge is power, Francis Bacon.")
///         .lineLimit(1)
public struct Markdown: View {
  @Environment(\.layoutDirection) private var layoutDirection: LayoutDirection
  @Environment(\.multilineTextAlignment) private var multilineTextAlignment: TextAlignment
  @Environment(\.sizeCategory) private var sizeCategory: ContentSizeCategory
  @Environment(\.markdownStyle) private var style: Markdown.Style
  @Environment(\.networkImageLoader) private var imageLoader
  @Environment(\.markdownScheduler) private var scheduler

  private var storage: Storage
  private var baseURL: URL?
  private var bundle: Bundle?

  public init(_ markdown: String, baseURL: URL? = nil, bundle: Bundle? = nil) {
    self.storage = .markdown(markdown)
    self.baseURL = baseURL
    self.bundle = bundle
  }

  public init(_ document: Document, baseURL: URL? = nil, bundle: Bundle? = nil) {
    self.storage = .document(document)
    self.baseURL = baseURL
    self.bundle = bundle
  }

  #if swift(>=5.4)
    public init(
      baseURL: URL? = nil,
      bundle: Bundle? = nil,
      @BlockArrayBuilder blocks: () -> [Block]
    ) {
      self.init(.init(blocks: blocks), baseURL: baseURL, bundle: bundle)
    }
  #endif

  public var body: some View {
    InternalView(
      storage: storage,
      environment: .init(
        baseURL: baseURL,
        bundle: bundle,
        layoutDirection: layoutDirection,
        multilineTextAlignment: multilineTextAlignment,
        style: style,
        imageLoader: imageLoader,
        mainQueue: scheduler
      )
    )
  }
}

extension View {
  /// Sets the markdown style in this view and its children.
  public func markdownStyle(_ markdownStyle: Markdown.Style) -> some View {
    environment(\.markdownStyle, markdownStyle)
  }

  public func onOpenMarkdownLink(perform action: @escaping (URL) -> Void) -> some View {
    environment(\.openMarkdownLink, .init(handler: action))
  }
}
