# share_gratitude


A modern Flutter app that allows users to create, edit, and delete gratitude posts with  themed gradient cards. 

The app features beautifully designed UI elements like gradient-colored cards, 
confirmation dialogs, and form validation, ensuring a smooth and modern user experience.


#  Features

-  Create, edit, and delete posts
- A custom splash screen is implemented using the flutter_native_splash package.
-  REST API integration using `http`
-  Riverpod for reactive state management
-  Gradient-themed post cards and dialog styling
-  Pull-to-refresh and instant UI updates



#  Tech Stack

- Flutter – UI framework
- Riverpod – State management
- HTTP – API communication
- Material 3 – Clean UI components

# Structure



# Api Handling

- All API operations are centralized in a dedicated ApiService class, ensuring a clean separation of concerns.

- The API handles all four CRUD operations:

 - GET to fetch posts
 - POST to create a new post
 - PUT to update existing posts
 - DELETE to remove posts by ID

JSON data is serialized and deserialized using manual
    -toJson() 
    -fromJson() methods in the Post model class.

Proper HTTP headers(Content-Type: application/json)are set for all requests to ensure valid API communication.

Exceptions are thrown for non-success status codes to handle errors gracefully.
API base URL is stored in a separate config file (ApiConfig) for easy updates and cleaner code.
The API service is consumed by Riverpod providers, which manage the state and expose it to the UI layer.
The UI automatically refreshes after create/update/delete by calling ref.invalidate() on the post list provider.
The structure makes API calls testable, modular, and easy to maintain.

# State Management

Riverpod is used as the state management solution for its simplicity, scalability, and performance benefits.

Provider is used to expose the API service (ApiService) throughout the app.

FutureProvider handles asynchronous data fetching, such as loading the list of posts from the API.

FutureProvider.family is used for actions that require parameters, like creating, updating, or deleting a specific post.

Automatic UI refresh is achieved using ref.invalidate() to re-trigger providers after create/update/delete operations.

onsumerWidget is used to reactively rebuild only the parts of the UI that depend on specific providers.

Scoped state access is achieved using ref.watch() to listen to provider changes only where needed.

Efficient rebuilds ensure only the necessary widgets update, improving performance.

Testable and modular design: state logic is fully separated from the UI, making it easy to maintain and extend.
