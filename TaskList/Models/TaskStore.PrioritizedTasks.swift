extension TaskStore {
  struct PrioritizedTasks {
    let priority: Task.Priority
    var tasks: [Task]
  }
}

extension TaskStore.PrioritizedTasks: Identifiable, Codable {
  var id: Task.Priority { priority }
}
