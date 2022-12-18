import MarkdownUI
import SwiftUI

struct QuotesView: View {
  let content = """
    You can quote text with a `>`.

    > Outside of a dog, a book is man's best friend. Inside of a
    > dog it's too dark to read.

    – Groucho Marx
    """

  var body: some View {
    DemoView {
      Markdown(self.content)

      Section("Customization Example") {
        Markdown(self.content)
      }
      .markdownTheme(
        \.blockquote,
        BlockStyle { label in
          label
            .padding()
            .markdownFontStyle {
              $0.lowercaseSmallCaps()
                .bold()
            }
            .overlay(alignment: .leading) {
              Rectangle()
                .fill(Color.teal)
                .frame(width: 4)
            }
            .background(Color.teal.opacity(0.5))
        }
      )
    }
    .navigationTitle("Quotes")
  }
}

//HStack(spacing: 0) {
//  RoundedRectangle(cornerRadius: 6)
//    .fill(Color.border)
//    .frame(width: .em(0.2))
//  label
//    .foregroundColor(.secondaryText)
//    .padding(.horizontal, .em(1))
//}
//.fixedSize(horizontal: false, vertical: true)

struct BlockquotesView_Previews: PreviewProvider {
  static var previews: some View {
    QuotesView()
  }
}
