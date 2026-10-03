import AppCore
import SwiftUI

@main
struct MacApp: App {
  var body: some Scene {
    WindowGroup {
      Text((try? greet("world")) ?? "Hello")
        .padding(40)
    }
  }
}
