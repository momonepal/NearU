# NearU - Hyperlocal Social Networking iOS App

![Swift](https://img.shields.io/badge/swift-F54A2A?style=for-the-badge&logo=swift&logoColor=white)
![IOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

| WIP |

<br>

NearU is a hyperlocal social networking Native iOS App built in Swift/XCode with a custom Parse backend that allows users to share hyperlocal content in real time, view the local feed, and comment on posts within their local area.

The idea is to build this into something like yikyak or Jodel, where the social media interaction and influence is bounded to proximity. 
There is no pressure to build a persona as there are no profiles, or personas. 

And here's the early [*Pitchdeck for NearU* ](https://www.canva.com/design/DAFQV3D42yQ/vUb4-sGxcMvWC38p0MGAyA/view?utm_content=DAFQV3D42yQ&utm_campaign=designshare&utm_medium=link&utm_source=viewer#1) 
There have been some deviations in the projects. This repo serves as a POC/MVP.

<br>

|          Sign Up/Login       |    View Posts & Add comments  |
| :--------------------------: | :---------------------------: |
| ![](assets/1.gif)            | ![](assets/2.gif)             |
|Post Content with caption     |        Sign Out               |
|  |  |
| ![](assets/3.gif)            | ![](assets/5.gif)             |

-------

User Stories

- [x] User can sign up to create a new account and log in.
- [x] User can take a photo, add a caption, and post it to the server. 
- [x] User can view the feed
- [x] User can view comments on a post and can add a new comment. 
- [x] User stays logged in across restarts/sessions. 
- [x] User can log out.
- [ ] User can pull to refresh.
- [ ] Posts are geofenced to a mile around user [WIP]


## Requirements

- iOS 9.0+
- [Xcode IDE](https://developer.apple.com/xcode/)
- [Install Cocoapods](https://www.raywenderlich.com/7076593-cocoapods-tutorial-for-swift-getting-started) (a dependency manager)

## Setup
- Clone the Repo
  ```
  $ git clone https://github.com/momonepal/NearU.git
  ```
-  Navigate to the unzipped folder in Terminal and run `pod install`.
- `$ open plan.xcworkspace` and Build the project (⌘+B)

<br>

-------------------------

### For more info on setting up
- https://developer.apple.com/xcode/
- https://cocoapods.org/
- https://www.raywenderlich.com/7076593-cocoapods-tutorial-for-swift-getting-started
- https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories

