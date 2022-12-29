import SwiftUI

public struct ListBullet: View {
  private let image: SwiftUI.Image

  public var body: some View {
    TextStyleAttributesReader { attributes in
      let fontSize = attributes.fontProperties?.scaledSize ?? FontProperties.defaultSize
      self.image.font(.system(size: round(fontSize / 3)))
    }
  }

  public static var disc: Self {
    .init(image: .init(systemName: "circle.fill"))
  }

  public static var circle: Self {
    .init(image: .init(systemName: "circle"))
  }

  public static var square: Self {
    .init(image: .init(systemName: "square.fill"))
  }
}
