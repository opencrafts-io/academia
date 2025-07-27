# Academia

The best student platform in the world

# How to build the application

## Dependencies
Ensure the following dependencies are installed
1. Flutter
2. The will to compile


1. Clone the project

```
git clone https://github.com/opencrafts-io/academia.git && cd academia
```

2. Install packages

```
flutter clean && flutter pub get
```

## Compilation steps

Academia utilizes [Android flavors](https://developer.android.com/build/build-variants) for certain build types and configurations
The following flavors are currently configured

1. developement - For a development kind of environment
2. staging - For a staging environment
3. production - For the main production environment

To run you can use the following command

```bash
flutter run --target=lib/main_<flavor>.dart --flavor=<flavor>
```

To build for a certain flavor you can use the following commands

```bash
flutter build apk --release  --target=lib/main_<flavor>.dart --flavor=<flavor>
```

For both commands substitute `<flavor>` with the actual flavor you want to build which probably will be `development`
in almost all scenarios

> Note that flavors are only supported for Android, ios and macos and will not work for Linux, Desktop and Web

To counter that we have setup flavor configuration using the target entry point and will propagate the configuration
to the application. 

Running the above commands on unsupported platforms will raise a warnig that its unsupported but will just build correctly



# A Word About Code Structure

This project follows the principles of **Clean Architecture**, which is designed to separate concerns and make the codebase more maintainable, testable, and scalable. Clean Architecture divides the system into layers that each handle a distinct responsibility, ensuring that changes in one layer don't negatively impact the others. Below, we will explore how the project is structured and some key concepts such as **error handling** and **dependency injection** that are central to maintaining clean and understandable code.

## Clean Architecture Layers

The project is organized into several key directories that represent different layers of the architecture:

- **Core Layer**: Contains the foundational components such as data structures, error handling, and network logic. This layer is independent of any specific business logic or UI. The `core` directory houses essential utilities that can be reused across the entire project, like network interceptors, error classes, and mixins for common functionality.
  
- **Features Layer**: Each feature in the application (like authentication, user profile, etc.) is structured as its own domain, with its own data, domain, and presentation layers. These layers follow the core principles of Clean Architecture:
    - **Data Layer**: Responsible for interacting with external systems like APIs or databases. It contains the data models and repositories to manage data retrieval and storage.
    - **Domain Layer**: Contains business logic such as use cases and entities. This is where the core business rules reside.
    - **Presentation Layer**: Responsible for the UI and state management. It contains the Bloc (for state management) and views that represent the user interface.

- **Config Layer**: Houses configuration files and router-related components. These files control global settings, routes, and the app's navigation logic, keeping them isolated from the business logic to maintain separation of concerns.

- **Database Layer**: Contains database-related components, including database initialization and database-specific models.

## Error Handling

One of the key philosophies of this codebase is **never throwing exceptions**. Instead of using traditional try-catch blocks, errors are handled in a more structured manner using **failures** and **either** type handling. This method leads to more predictable and testable code.

- **Failures**: Custom failure classes are used to represent different types of errors that might occur in the system. These failures are part of the business logic and are passed along through the application's layers.

- **Either**: Rather than throwing exceptions, the project utilizes the **Either** type (common in functional programming). This type is used to represent a result that can either be a success (`Right`) or a failure (`Left`). This approach forces the developer to handle both cases explicitly, improving reliability and reducing the chance of unhandled exceptions.

For example, if an API request fails, it doesn't throw an error. Instead, the failure is encapsulated as a `Left` in the `Either` type, which is then passed along to the UI or business logic for appropriate handling, such as displaying an error message.

### Example:
```dart
Either<Failure, UserProfile> result = await userProfileRepository.getUserProfile();

result.fold(
  (failure) => showError(failure),  // Handle failure
  (profile) => showProfile(profile), // Handle success
);
```

### Dependency injection
The project leverages dependency injection to manage object creation and dependencies throughout the application. The injection_container.dart file is responsible for setting up and providing the required dependencies to various parts of the application.

Instead of directly instantiating classes throughout the codebase, we use a centralized mechanism to "inject" the necessary dependencies. This ensures that the application components remain decoupled and easier to test, maintain, and scale.

By using dependency injection, we ensure that:

    Dependencies are easily swapped for testing purposes (mock services or repositories can be injected during tests).

    Components don't have to worry about the lifecycle of their dependencies, which reduces the likelihood of errors like memory leaks or incorrect configurations.

    The overall architecture remains modular and flexible, with each component focusing on its core responsibility.



