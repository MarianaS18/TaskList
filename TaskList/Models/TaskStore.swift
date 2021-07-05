import Combine
import Foundation

class TaskStore: ObservableObject {    
    @Published var prioritizedTasks: [PrioritizedTasks] = []
    
    init() {
        loadJSONPrioritizedTasks()
    }
  
  func getIndex(for priority: Task.Priority) -> Int {
    prioritizedTasks.firstIndex { $0.priority == priority }!
  }
    
    private func loadJSONPrioritizedTasks() {
        /// print(Bundle.main.bundleURL)
        print(FileManager.documentsDirectoryURL)
        /// let temporaryDirectoryURL = FileManager.default.temporaryDirectory
        /// print(temporaryDirectoryURL)
        
        // get the URLs for each of the JSON files. For that ou will use bundles URL
        // Bundle is a representation of your app, its code and resources
        // All the files you add in xcode to your app target are pakeged up into what is referred to as the app bundle
        // main represents the current executable, in this case your app
        // by asking your main bundle for the URL for a given resource and assuming it's located in the bundle, you will get back the URL where the file is located
        // forResource: is the name of the file you want the URL for
        // withExtension: is the file extension of the file
        /// guard let tasksJSONURL = Bundle.main.url(forResource: "PrioritizedTasks", withExtension: "json") else { return }
        
        // or the another way:
        let tasksJSONURL = URL(fileURLWithPath: "PrioritizedTasks", relativeTo: FileManager.documentsDirectoryURL).appendingPathExtension("json")
        
        // Filemanager also provides you with a handy method (contentsOfDirectory) to acquire (для получения) a string array of the contents of a particular directory which will be perfect for knowing what files are available in your different sandbox directories
        // atPath: is a string with the path that to the directory you want to get the contents for
        print((try? FileManager.default.contentsOfDirectory(atPath: FileManager.documentsDirectoryURL.path)) ?? [])
        
        // JSONDecoder helps you decode JSON object into instances of a given data type (instances of task og prioritized task
        let decoder = JSONDecoder()
        
        // you use the data initializer that takes your URL
        do {
            let tasksData = try Data(contentsOf: tasksJSONURL)
            // type: is the type to decode from your data. You are loading a task so using TaskStore.PrioritizedTasks.self (array of) will tell to the method
            // from: is the JSON object to decode
            prioritizedTasks = try decoder.decode([TaskStore.PrioritizedTasks].self, from: tasksData)
        } catch let error {
            print(error)
        }
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
