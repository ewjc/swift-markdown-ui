import SwiftUI

struct TaskListItemView: View {
  @Environment(\.old_theme.taskListMarker) private var taskListMarker

  private let item: TaskListItem

  init(item: TaskListItem) {
    self.item = item
  }

  var body: some View {
    Label {
      BlockSequence(self.item.blocks)
    } icon: {
      self.taskListMarker
        .makeBody(.init(isCompleted: self.item.isCompleted))
        .markdownFont()
    }
  }
}
