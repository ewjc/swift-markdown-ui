import SwiftUI

extension EnvironmentValues {
  var tightSpacingEnabled: Bool {
    get { self[TightSpacingEnabledKey.self] }
    set { self[TightSpacingEnabledKey.self] = newValue }
  }
}

private struct TightSpacingEnabledKey: EnvironmentKey {
  static var defaultValue = false
}

extension EnvironmentValues {
  var listLevel: Int {
    get { self[ListLevelKey.self] }
    set { self[ListLevelKey.self] = newValue }
  }
}

private struct ListLevelKey: EnvironmentKey {
  static var defaultValue = 0
}

extension EnvironmentValues {
  var hasSuccessor: Bool {
    get { self[HasSuccessorKey.self] }
    set { self[HasSuccessorKey.self] = newValue }
  }
}

private struct HasSuccessorKey: EnvironmentKey {
  static var defaultValue = false
}
