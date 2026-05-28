# Movie Category Explorer

A Flutter application that allows users to search movies by category using the OMDb API.

## Features

- Search movies by category
- Movie details screen
- Pagination (load more movies)
- Favorites support
- Local database using Hive
- Responsive UI using MediaQuery
- Riverpod state management
- MVVM architecture
- Dependency Injection
- Dio + Retrofit API integration
- Flavors support
- Loading and error handling
- Dark theme UI

## Architecture

This project follows:

- MVVM Architecture
- Repository Pattern
- Riverpod State Management
- Dependency Injection

## Technologies Used

- Flutter
- Riverpod
- Dio
- Retrofit
- Hive
- MediaQuery
- OMDb API

## Folder Structure

```text
lib/

models/
providers/
repositories/
screens/
services/
viewmodels/
```

## API Used

OMDb API

https://www.omdbapi.com/

## Run Project
```text
flutter pub get
flutter run -t lib/main_dev.dart
