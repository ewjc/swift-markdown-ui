import SwiftUI

// Adopted and adapted from https://github.com/jordansinger/SwiftUI-Kit

struct DemoSection<Content>: View where Content: View {
  var title: String?
  var description: String
  var content: () -> Content

  init(
    title: String? = nil,
    description: String,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.title = title
    self.description = description
    self.content = content
  }

  var body: some View {
    Group {
      #if os(iOS)
        Section(footer: Text(description)) {
          if let title = title {
            Text(title)
              .font(.headline)
          }
          content()
        }
      #else
        Group {
          if let title = title {
            Text(title)
              .font(.title3)
              .bold()
          }
          content()
          Text(description)
            .font(.body)
            .foregroundColor(.secondary)
          Divider()
        }
      #endif
    }
  }
}
