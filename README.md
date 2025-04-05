# GitHub-Profile-App

A SwiftUI app that allows users to search GitHub profiles and view user information like, bio, avatar, name , followers, and followings.


## Features

- Search for GitHub users by username
- View user profiles with avatar, name, bio, and stats
- Navigate to followers and following lists
- Tap on users to view their profiles
- Pull to refresh for updated data
- Skeleton loading screens
- Profile caching with automatic invalidation


## Installation guideline

1. Clone the repository
2. Open the project in Xcode
3. Build and run the application on a simulator or device


## GitHub API Integration

The app uses the GitHub REST API to fetch user data. The main endpoints used are:

- `GET /users/{username}` - Get a user's profile
- `GET /users/{username}/followers` - Get a user's followers
- `GET /users/{username}/following` - Get users a user is following


## Screenshots

| Following User Profile Screen | Following List Screen |
| --- | --- |
| <img src="./Screenshots/5.png" alt="Following User Profile Screen" width="300"/> | <img src="./Screenshots/3.png" alt="Following List Screen" width="300"/> |

| Profile Screen | Search Screen |
| --- | --- |
| <img src="./Screenshots/2.png" alt="Home - Book List Screen" width="300"/> | <img src="./Screenshots/1.png" alt="Search Screen" width="300"/> |

## Screen Recording
<img src="./Screenshots/rec.gif" alt="App in Action" width="300"/>
