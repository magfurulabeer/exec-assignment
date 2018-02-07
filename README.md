# exec-assignment

## Prerequisites
- MacOS 10+
- Xcode 9+
- CocoaPods Gem

## How To Set Up The Application
- Assuming you're on a Mac with Xcode 9, start by cloning the repo
- Once cloned, run 'pod install' in the projects root directory
- Open Assignment.xcworkspace
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
- It makes sense to attempt to keep the frontend as faithful to the backend. It's difficult to work with frontend who's models do not resemble the backend models
2. Balancing Separation of Concerns with Minimizing Boilerplate and Overhead
- Separation of Concerns is a crucial design principle for improving maintainability but when overdone it actually severly diminishes maintainability
3. Ease of File Navigation
- Extending the last point, when separated correctly with a solid system in place, it becomes significantly easier to find which file contains the desired code

## Models
All the models in the app are Realm Objects and conform to the Mappable protocol. This means that it can easily be created given the proper JSON. The model properties were kept as faithful as possible to the recieved JSON (e.g. current_segment became currentSegment).
1. User
2. Course
3. Module
4. LectureSegment
5. Slide
