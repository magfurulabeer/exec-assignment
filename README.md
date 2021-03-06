# exec-assignment -- INCOMPLETE

## Prerequisites
- MacOS 10+
- Xcode 9+
- CocoaPods Gem

## How To Set Up The Application
- Assuming you're on a Mac with Xcode 9, start by cloning the repo
- Once cloned, run 'pod install' in the projects root directory
- Open Assignment.xcworkspace
- After clicking the topmost directory on the right (Assignment with blue icon), you'll see in the EditorView the Project Settings. Change the bundle identifier to your personal or commercial identifier (com.yourcompanyname.Assignment)
- Cmd-R to Build and Run

## Running Tests
- Unit tests have yet to be implemented but once they are, you can use Cmd-U to run them

# Overview

## Pods
- Moya - For the Networking Layer
- RealmSwift - For Persistence
- ObjectMapper - For JSON Object mapping
- Kingfisher - For downloading and caching images
- KeychainAccess - For simple Keychain use
- Then - For Promises and Async Management

## General Architecture
The architecture used in this app is MVVM-C (Model-View-ViewModel-Coordinator). There was a deliberate decision not to use RxSwift as it can be difficult to read for those unfamiliar with it's syntax and concepts. It also does not support Swift 4 at the moment.

## Architectural Motifs
Many of the decisions made when architecting this app were based on the following 3 themes:
1. Backend Frontend Synchronization
- It makes sense to attempt to keep the frontend as faithful to the backend. It's difficult to work with frontend whose models do not resemble the backend models
2. Balancing Separation of Concerns with Minimizing Boilerplate and Overhead
- Separation of Concerns is a crucial design principle for improving maintainability but when overdone it actually severely diminishes maintainability
3. Ease of File Navigation
- Following up on that last point, when separated correctly with a solid system in place, it becomes significantly easier to find the correct file that contains the specific logic being searched for

## Model
All the models in the app are Realm Objects and conform to the Mappable protocol. This means that it can easily be created given the proper JSON. The model properties were kept as faithful as possible to the recieved JSON (e.g. current_segment became currentSegment).
1. User
2. Course
3. Module
4. LectureSegment
5. Slide

## View
The majority of the styling was done using Storyboard. The idea is that there would be multiple storyboards for multiple flows. Currently there are only 2: Login and App. If the App had a TabBar, this figure could have easily been 5 or 6. While the storyboards hold the layouts of the View Controller, the actual loading of the View Controllers are done in the Coordinator.

All View Controllers have an associated View Model that contains the state, interaction logic, and presentation logic. The View Model is injected into the View Controller by the Coordinator.

## View Model
Any state (The email and password values of the fields in the login screen), presentation logic (Showing dates in MM/DD/YYYY format), and interaction logic (Navigating to a different View Controller on tap) is abstracted away into the View Model.

Every View Model is injected with a Coordinator and occasionally injected with an update function directly from the View Controller. The actual navigation logic is delegated to the Coordinator. 

## Coordinator
The Coordinator handles the navigation of the app. Each View Controller and View Model pair is separated into their own Scene. The Coordinator can then push, pop, or change root to the proper scene (No modals in this app). The Coordinator is owned by the AppDelegate. References to it are passed to every View Model instantiated. 

## Networking
Networking is separated into 3 components: The Client, The Services, The Managers. 

### Client
The Client is the main component of the Networking Layer. The Client will be used to make the actual network calls. The Client in this app is a Moya Provider. Moya has a clean and consistent interface for creating networking layers. Only services should access the Client.

### Services
Each set of network calls is grouped by their path. Each one of those groups is a Network Service. They were deliberately separated to reflect the Swagger Docs. This project contains a TokenService, a UserService, and a CourseService. Each task in a service will return a Promise with the JSON Dictionary/Array or optionally a selected value or mapped Model object. Only Managers shoould access the Services.

### Manager
The Manager is the "face" of the Network Layer. It usually contains the intersection between the Networking Layer and the Persistence Layer. View Models use Managers to do generalized network tasks. Unlike Services that have many individual calls, a Manager has many different "orchestras." The Manager orchestrates a series of calls and actions that may span multiple services and affect other layers of the app. An example would be the LoginManager. It has a function called login(email:password:) that requests a token, saves the token to the Keychain, fetches the User, and then saves the User object into Realm. To do this, it uses 2 Network Services, the Keychain, and Realm. This exact method is used by the LoginViewModel when the Login button is tapped.
