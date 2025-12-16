<!-- Auto-generated for AI coding agents. Keep concise and repo-specific. -->
# Copilot / AI agent instructions — final_project_news_app

Purpose: quickly orient an AI agent to this Flutter news app so changes are correct, minimal, and follow repo conventions.

- **Entrypoint**: `lib/main.dart` — small MaterialApp stub. All app wiring (routing, DI, app-level setup) lives under `lib/`.
- **Core directories**:
  - `lib/blocs/` — state management (BLoC-style). Look for files suffixed `bloc`/`event`/`state`.
  - `lib/data/remote_data/` — network/data-source layer (API clients). It's currently empty; use this for HTTP clients and responses.
  - `lib/models/` — plain data models and JSON (de)serialization logic.
  - `lib/pages/` — UI screens and page-level widgets.

- **High-level data flow**: remote_data -> models -> blocs -> pages. When adding features, add a remote client in `remote_data`, a model in `models`, a bloc in `blocs`, and a page in `pages` that subscribes to the bloc.

- **Build & run (quick)**
  - Install dependencies: `flutter pub get`
  - Run on connected device: `flutter run` (or `flutter run -d <device-id>`)
  - Build Android on Windows: `cd android && gradlew.bat assembleDebug`
  - Run tests: `flutter test` (project currently has no tests; add tests under `test/` following Flutter defaults)

- **Platform & CI notes**:
  - Android uses Gradle Kotlin DSL (`android/app/build.gradle.kts` and `android/build.gradle.kts`). Use the repository `gradlew` wrappers; on Windows prefer `gradlew.bat`.
  - iOS native files are under `ios/Runner` — modify only when implementing platform channels or entitlements.

- **Dependencies & environment**:
  - See `pubspec.yaml`. Current SDK constraint is `^3.11.0-93.1.beta` — be cautious: this indicates a pre-release/tooling expectation. Verify `flutter --version` and match the local SDK where possible.
  - Linting: `flutter_lints` is included; follow existing lint rules when adding code.

- **Project-specific conventions**:
  - Keep UI in `lib/pages` and avoid placing business logic there — use `blocs` for state and `data` for I/O.
  - Name files using lower_snake_case; BLoC files should include `bloc` in the filename (e.g., `news_list_bloc.dart`).
  - Prefer small, focused widgets for pages; extract reusable widgets into `lib/widgets/` if needed (folder can be added).

- **Generated artifacts & build output**:
  - `build/` contains Flutter build artifacts and generated assets. Do not commit build outputs.

- **When editing project files** (AI agent checklist)
  1. Update `pubspec.yaml` only when adding/removing packages. After changes run `flutter pub get`.
  2. If native Android/iOS changes are made, update gradle wrappers or platform files and verify platform-specific build: `cd android && gradlew.bat assembleDebug` (Windows) or use `./gradlew` on mac/linux.
  3. Run the app locally (`flutter run`) to validate integration; update affected widgets/blocs to preserve UI and state flows.

- **Examples from this repo**:
  - Entrypoint: `lib/main.dart` — start here to understand app lifecycle.
  - Add network client: add `lib/data/remote_data/news_api.dart`, model `lib/models/news_item.dart`, `lib/blocs/news_bloc.dart`, and `lib/pages/news_page.dart` following the data flow above.

- **Do NOT assume**:
  - There are no existing tests or CI workflows in the repo; create tests and CI configs only after confirming with the maintainer.

If anything here is unclear or you'd like more details (examples, naming templates, or a proposed PR skeleton), tell me which area to expand. 
