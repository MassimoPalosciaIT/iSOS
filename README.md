<p align="center">
  <img src="https://github.com/MassimoPalosciaIT/iSOS/blob/1b24830b74fd088efd185adf6b3d45ce07377228/YahaIconRounded.png" alt="Logo" width="80" height="80">
  <h2 align="center">
    Yaha App
  </h2>
</p>

<img src="https://github.com/matt-novoselov/matt-novoselov/blob/fa4553c1e2ba92cb77bf1d11d272d0c1ad5de138/Files/ios17.svg" alt="SwiftUI" style="height: 30px"> <img src="https://github.com/matt-novoselov/matt-novoselov/blob/fa4553c1e2ba92cb77bf1d11d272d0c1ad5de138/Files/SwiftUI.svg" style="height: 30px"> <img src="https://github.com/matt-novoselov/matt-novoselov/blob/fa4553c1e2ba92cb77bf1d11d272d0c1ad5de138/Files/CoreLocation.svg" alt="SwiftUI" style="height: 30px"> <img src="https://github.com/matt-novoselov/matt-novoselov/blob/fa4553c1e2ba92cb77bf1d11d272d0c1ad5de138/Files/MapsKit.svg" alt="SwiftUI" style="height: 30px">

Yaha helps you connect to the appropriate emergency services based on your location, as well as access first aid tips, locate nearby hospitals, and bridge language barriers with pre-built conversation templates. Stay safe with Yaha.

<a href="https://youtu.be/C-nO2l34tNM" target="_blank">
  <img src="https://github.com/MassimoPalosciaIT/iSOS/assets/59065228/3816afd0-ed60-4369-a039-d85ed58b7000" alt="GIF">
</a>

[![](https://github.com/matt-novoselov/matt-novoselov/blob/34555effedede5dd5aa24ae675218d989e976cf6/Files/YouTube_Badge.svg)](https://youtu.be/C-nO2l34tNM)
[![](https://github.com/matt-novoselov/matt-novoselov/blob/eb675928f9e5b3cd2a2db6cde2b6ecf5ab646b4c/Files/Available_on_the_Test_Flight.svg)](https://testflight.apple.com/join/Qyfhv1vH)


## Description
The app was built using **SwiftUI** to create a visual interface.

The app uses **CoreLocation** to determine the user’s coordinates. GPS technology enables us to calculate user’s coordinates without an internet connection. After that we process user’s coordinates through a [local offline reverse geocoding library](https://github.com/Alterplay/APOfflineReverseGeocoding) to identify the country in which the user is located. This process is entirely automated and doesn’t require an internet connection, ensuring that people can use our app even in the most remote locations. All emergency phone numbers for various types of emergencies across all countries are stored in the local database. When the app has internet access, it connects to the Apple’s reverse geocoding server to determine the exact address of the user.

**MapsKit** is used to display nearby hospitals and police offices on the map, enabling users to find directions to these locations.

Our app incorporates accessibility features to assist our users, including support for VoiceOver.

## Requirements
- iOS 17.0+
- Xcode 15.0+

## Installation
1. Open Xcode.
2. Click on **"Clone Git Repository"**.
3. Paste the following URL: `https://github.com/MassimoPalosciaIT/iSOS.git`
4. Click **"Clone"**.
5. Build and run the project in Xcode.

## Dependencies
- [APOfflineReverseGeocoding](https://github.com/Alterplay/APOfflineReverseGeocoding) - Local Reverse Geocoding library

<br>

## Credits

Yaha includes first aid tips sourced from the [World Health Organization website](https://www.who.int/).

Distributed under the MIT license. See **LICENSE** for more information.

Developed with ❤️ by One Piece Team
