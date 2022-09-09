import SwiftUI

internal struct BlockquoteView: View {
  @Environment(\.theme.blockquote) private var style
  @Environment(\.theme.indentSize) private var indentSize
  @Environment(\.font) private var font
  @Environment(\.multilineTextAlignment) private var textAlignment

  private var blockquote: Blockquote

  init(_ blockquote: Blockquote) {
    self.blockquote = blockquote
  }

  var body: some View {
    style.makeBody(
      .init(
        content: .init(BlockGroup(blockquote.children)),
        font: font,
        textAlignment: textAlignment,
        indentSize: indentSize
      )
    )
    // Re-add the last paragraph spacing after applying the style
    .paragraphSpacing()
  }
}
