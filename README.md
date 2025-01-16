
Design Decisions
State Management: I choose bloc for state management to keep the app simple and efficient while ensuring that tasks are properly updated and synced throughout the app.
Local Storage: SharedPreferences was used to store tasks persistently, allowing the user to access them even after closing and reopening the app.
Pagination: Implemented pagination to manage the efficient fetching of large datasets of tasks using the API’s limit and skip query parameters.


Challenges Faced
API Integration: Initially faced challenges with correctly implementing the API for task management, particularly when handling pagination and syncing task data.
State Management Complexity: Ensuring efficient updates across the app while minimizing unnecessary rebuilds required some optimization in the state management implementation.
Unit Testing: Writing tests to handle network requests with mock responses and validating CRUD operations was tricky but necessary to ensure robust app behavior
