import Foundation

struct Task: Identifiable, Codable {
    var id = UUID()
  
  var name: String
  var completed = false
}
