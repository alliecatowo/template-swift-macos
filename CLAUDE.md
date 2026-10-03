# CLAUDE.md

Guidance for AI agents (and humans) working in the **template-swift-macos** repo.

## What template-swift-macos is

macOS Swift app template with CI and docs. A SwiftPM-first macOS app (SwiftUI): logic in the `AppCore` library, UI in the `MacApp` executable.

## Commands

`mise trust && mise install` once per clone (installs lefthook; it hooks itself in). **Swift comes from Xcode 16+ / Swift 6 toolchain** (`xcode-select -p`), not mise. Linux has no SwiftUI, so this template builds only on macOS.

- `mise run check`: `swift format lint` over Sources/Tests. **Must be clean before committing.** `mise run fmt` fixes.
- `mise run test`: `swift test` (XCTest). **Must be green.**
- `mise run build`: `swift build -c release`. Run the app with `swift run template-swift-macos`.

CI runs the same tasks on `macos-26`. (JavaScript tooling, if you add any, uses pnpm.)

## Architecture

- `Sources/AppCore/`: pure logic, no UI imports. Put everything testable here.
- `Sources/MacApp/`: SwiftUI `@main` app. Keep it thin.
- `Tests/AppCoreTests/`: XCTest.
- `App/Info.plist`, `App/App.entitlements`: stubs for bundling a real `.app`. SwiftPM alone makes a bare executable; to ship a `.app`, assemble `Contents/MacOS` + `Info.plist` in a mise task or move to an Xcode project (XcodeGen if you want it generated).

## Conventions that bite

- **Visually verify UI changes.** Build and launch, then screenshot the window (`screencapture -l <window id> -x out.png`) and look at it; a green build proves nothing about layout. Prefer XCUITest with screenshot attachments for structured traversal.
- Don't commit `.build/`, `.swiftpm/` or `DerivedData/`.
- Executable targets and `@main`: the file with `@main` must not be named `main.swift`.

## Things that bit us

- (none yet)

## Signing and notarization

Not wired up in CI. To distribute outside the App Store: sign with a Developer ID Application certificate and the hardened runtime (`codesign --options runtime --entitlements App/App.entitlements`), then `xcrun notarytool submit --wait` with an app-specific password or API key stored as repo secrets, then `xcrun stapler staple`. Never commit certificates or keys.

## Changelog

`CHANGELOG.md` follows [Keep a Changelog](https://keepachangelog.com). Every user-facing change adds a bullet under `## [Unreleased]` in the same change as the code.

## Git workflow

- Branch off `main`. Conventional commits (lefthook `commit-msg`). PRs are draft by default.
- **Worktrees go in `.claude/worktrees/<branch-with-dashes>` inside this repo.** Never under `/tmp` or a scratchpad. Remove after merge.
- Dependabot patch/minor PRs auto-merge on green; major bumps need a human.

## Docs site

`docs/` is a [Zola](https://www.getzola.org) site (single binary, no Node): `zola --root docs serve` to preview, `zola --root docs check` to verify links. Content lives in `docs/content/`, the theme in `docs/templates/`. `.github/workflows/docs.yml` builds it on every change and deploys it to GitHub Pages from `main` (needs Settings > Pages > Source: "GitHub Actions"; until then the deploy job skips itself). A dead internal link fails the build, so link repo files via github.com URLs.
