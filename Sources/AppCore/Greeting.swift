import Foundation

/// Errors the core can throw.
public enum GreetingError: Error, Equatable {
  case emptyName
}

/// Builds the greeting for `name`.
public func greet(_ name: String) throws -> String {
  let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
  guard !trimmed.isEmpty else { throw GreetingError.emptyName }
  return "Hello, \(trimmed)!"
}
