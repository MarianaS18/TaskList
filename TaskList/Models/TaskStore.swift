import Combine

class TaskStore: ObservableObject {    
  @Published var prioritizedTasks = [
    PrioritizedTasks(
      priority: .high,
      names: [
        "Code a SwiftUI app",
        "Book an escape room",
        "Walk the cat",
        "Pick up heavy things and put them down"
      ]
    ),
    PrioritizedTasks(
      priority: .medium,
      names: [
        "Make karaoke playlist",
        "Present at iOS meetup group",
      ]
    ),
    PrioritizedTasks(
      priority: .low,
      names: [
        "Climb El Capitan"
      ]
    ),
    PrioritizedTasks(
      priority: .no,
      names: [
        "Learn to make baklava",
        "Play disc golf in every state",
        "100 movie reboot marathon"
      ]
    )
  ]
  
  func getIndex(for priority: Task.Priority) -> Int {
    prioritizedTasks.firstIndex { $0.priority == priority }!
  }
}

private extension TaskStore.PrioritizedTasks {
  init(priority: Task.Priority, names: [String]) {
    self.init(
      priority: priority,
      tasks: names.map { Task(name: $0) }
    )
  }
}
