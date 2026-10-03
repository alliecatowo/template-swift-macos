// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "template-swift-macos",
  platforms: [.macOS(.v14)],
  products: [
    // The shipping executable; `swift build -c release` produces .build/release/template-swift-macos.
    .executable(name: "template-swift-macos", targets: ["MacApp"]),
    .library(name: "AppCore", targets: ["AppCore"]),
  ],
  targets: [
    // Logic lives here so it is unit-testable without launching the UI.
    .target(name: "AppCore"),
    .executableTarget(name: "MacApp", dependencies: ["AppCore"]),
    .testTarget(name: "AppCoreTests", dependencies: ["AppCore"]),
  ]
)
