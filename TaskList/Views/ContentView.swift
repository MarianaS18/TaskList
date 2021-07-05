import SwiftUI

struct ContentView: View {
  @ObservedObject var taskStore: TaskStore
  @State var modalIsPresented = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(taskStore.prioritizedTasks) { index in
          SectionView(prioritizedTasks: self.$taskStore.prioritizedTasks[index])
        }
      }
      .listStyle( GroupedListStyle() )
      .navigationBarTitle("Tasks")
      .navigationBarItems(
        leading: EditButton(),
        trailing:
          Button(
            action: { self.modalIsPresented = true }
          ) {
            Image(systemName: "plus")
          }
      )
    }
    .sheet(isPresented: $modalIsPresented) {
      NewTaskView(taskStore: self.taskStore)
    }
    .onAppear() {
        self.loadJSON()
    }
  }
    
    private func loadJSON() {
        // get the URLs for each of the JSON files. For that ou will use bundles URL
        // Bundle is a representation of your app, its code and resources
        // All the files you add in xcode to your app target are pakeged up into what is referred to as the app bundle
        // main represents the current executable, in this case your app
        // by asking your main bundle for the URL for a given resource and assuming it's located in the bundle, you will get back the URL where the file is located
        // forResource: is the name of the file you want the URL for
        // withExtension: is the file extension of the file
        guard let taskJSONURL = Bundle.main.url(forResource: "Task", withExtension: "json"),
              let prioritizedTaskJSONURL = Bundle.main.url(forResource: "PrioritizedTask", withExtension: "json")
              else { return }
        
        // JSONDecoder helps you decode JSON object into instances of a given data type (instances of task og prioritized task
        let decoder = JSONDecoder()
        
        // you use the data initializer that takes your URL
        do {
            let taskData = try Data(contentsOf: taskJSONURL)
            // type: is the type to decode from your data. You are loading a task so using Task.self will tell to the method
            // from: is the JSON object to decode
            let task = try decoder.decode(Task.self, from: taskData)
            print(task)
            
            let prioritizedTaskData = try Data(contentsOf: prioritizedTaskJSONURL)
            let prioritizedTask = try decoder.decode(TaskStore.PrioritizedTasks.self, from: prioritizedTaskData)
            print(prioritizedTask)
        } catch let error {
            print(error)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView( taskStore: TaskStore() )
  }
}
