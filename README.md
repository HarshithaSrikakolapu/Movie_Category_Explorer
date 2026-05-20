# Movie Category Explorer

A Flutter movie search app built using the OMDb API.

## Features

- Search movies by category
- View movie details
- Pagination
- Favorites
- Error handling
- Pull to refresh

## Concepts Used

- Provider State Management
- Dio
- Retrofit
- Repository Pattern
- Dependency Injection
- Isolates using `compute()`

## Dependency Injection

Used constructor injection for loose coupling.

```dart
MovieRepository(this.service);
```

## Isolate Usage

Used `compute()` to parse JSON in background isolate.

```dart
final response = await compute(
  parseMovies,
  jsonEncode(rawJson),
);
```

## API Used

https://www.omdbapi.com/

## Run Project

```bash
flutter pub get
```

```bash
dart run build_runner build --delete-conflicting-outputs
```

```bash
flutter run
```

## Architecture

```text
UI
↓
ViewModel
↓
Repository
↓
Service
↓
OMDb API
```
