# ActivitiesNM - Activity Management iOS App

## Overview
ActivitiesNM is an iOS application designed to manage and display various activities. The app features several view controllers to handle different functionalities, including activity details, map views, discovery of new activities, and adding new activities. This document provides an overview of the technology stack used in the app and a detailed description of each view controller.

## Technology Stack

### Swift
- **Swift**: Primary programming language used for developing the app, leveraging its modern syntax and safety features.

### UI and Layout
- **UIKit**: Framework for building and managing the user interface.
- **Auto Layout**: Programmatic approach to define the user interface's layout to support various screen sizes and orientations.
- **Custom Views**: All UI elements are created programmatically without using Storyboards or XIBs, providing greater control and flexibility.

### Data Management
- **CoreData**: Framework for managing the app's data model, used for storing and retrieving activities.
- **NSFetchedResultsController**: Used to manage the results of Core Data fetch requests and to provide data for the table views, ensuring efficient data management and UI updates.

### Networking
- **URLSession**: Framework for handling network requests, used for fetching activity data from a remote server.
- **JSON**: Data format used for network communication, parsed using Swift's Codable protocol to ensure type-safe data handling.

### Map and Location
- **MapKit**: Framework for displaying maps and embedding map views.
- **CoreLocation**: Framework for handling location services and geolocation, used for fetching and displaying user and activity locations.

### Concurrency and Asynchronous Programming
- **Combine**: Framework for handling asynchronous events by combining event-processing operators. Used for UI updates and Core Data changes, ensuring smooth and responsive user interactions.

### User Interface Components
- **UITableView**: Used extensively for displaying lists of activities.
- **UITableViewDiffableDataSource**: Manages data and presentation for table views with modern diffable data source API, providing efficient and animated updates to the table view.
- **Custom Cells**: Custom UITableViewCell subclasses for different types of content, providing a tailored user experience.

### User Interaction
- **Delegate Pattern**: Used for handling interactions and communication between view controllers, ensuring a modular and reusable code structure.
- **Target-Action**: Mechanism for connecting UI controls to their actions, enabling interactive UI components.

## View Controllers

### DiscoverTableViewController
Responsible for displaying a list of activities in a table view.

- **Technologies**: UIKit, UITableView, UITableViewDiffableDataSource, NSFetchedResultsController.
- **Description**: Displays a list of activities using a UITableView. Uses UITableViewDiffableDataSource for managing data and presentation. Data is fetched using NSFetchedResultsController.
- **Custom UI**: All UI components are instantiated and laid out programmatically.

### ActivityDetailViewController
Displays detailed information about a selected activity.

- **Technologies**: UIKit, UITableView, Custom Cells (ActivityDetailTextCell, ActivityDetailTwoColumnCell, ActivityDetailMapCell), CoreData, Combine.
- **Description**: Shows detailed information in a table view with custom cells. Includes a custom header and footer view. Manages activity details and favorites using CoreData. Handles asynchronous UI updates with Combine.
- **Custom UI**: All UI components are instantiated and laid out programmatically.

### MapViewController
Displays the location of an activity on a map.

- **Technologies**: MapKit, CoreLocation, UIKit.
- **Description**: Displays the activity location on a map using MapKit. Fetches and displays the user's current location with CoreLocation. Custom annotations mark activity locations on the map.
- **Custom UI**: All UI components are instantiated and laid out programmatically.

### ReviewViewController
Handles user reviews and ratings for activities.

- **Technologies**: UIKit, CoreData, Delegate Pattern.
- **Description**: Provides UI for users to input reviews and ratings. Saves reviews using CoreData and communicates rating changes back to ActivityDetailViewController using the delegate pattern.
- **Custom UI**: All UI components are instantiated and laid out programmatically.

### ActivitiesTableViewController
Displays a list of all activities stored in the app.

- **Technologies**: UIKit, UITableView, UITableViewDiffableDataSource, NSFetchedResultsController.
- **Description**: Shows a list of all activities using a UITableView. Manages data and presentation with UITableViewDiffableDataSource and NSFetchedResultsController. Implements swipe actions for deleting activities.
- **Custom UI**: All UI components are instantiated and laid out programmatically.
- **Swipe Actions**: Enables swipe gestures for deleting activities, enhancing user interaction.

### NewActivityViewController
Handles the creation of new activities.

- **Technologies**: UIKit, CoreData, UIImagePickerController, Delegate Pattern.
- **Description**: Provides UI for users to input details for a new activity. Allows users to pick a photo for the activity using UIImagePickerController. Saves the new activity using CoreData.
- **Custom UI**: All UI components are instantiated and laid out programmatically.

#### Photo Selection
- **UIImagePickerController**: Used for selecting photos from the user's photo library or camera. Implements the delegate pattern to handle the selected image and update the activity's image property.

### Additional Technologies
- **NSFetchedResultsControllerDelegate**: Monitors changes to the Core Data context and updates the table views accordingly.
- **CLGeocoder**: Converts between geographic coordinates and place names, used in MapViewController for reverse geocoding.
- **UIDynamicSystemColor**: Provides dynamic color changes based on system settings (e.g., light and dark mode).

## Network Interaction

### Network Handling
- **Fetching Data**: Data is fetched from a remote server using URLSession. The responses are parsed and used to update the Core Data model.
- **Error Handling**: Network errors are handled gracefully, with appropriate user feedback.
- **Caching**: Responses are cached to improve performance and reduce network load.

## Conclusion
The ActivitiesNM app is built using a robust and modern technology stack that leverages Swift, UIKit, CoreData, and various Apple frameworks to provide a smooth and efficient user experience. The app's architecture ensures clean code organization and maintainability, making it easy to add new features and improvements in the future.
