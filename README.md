# hkSymposium
### Overview
It is a demo project for evaluation purposes. It is an app for cinephiles and movie hobbyists to get an update about upcoming movies, based on The Movie Database (TMDb) API.

### Screenshot

![Screenshot image](https://github.com/heuristisk/hkSymposium/blob/development/hkSymposium/resource/screenshots/screenshot.png?raw=true)

### Navigation animation

![Screenshot image](https://github.com/heuristisk/hkSymposium/blob/development/hkSymposium/resource/screenshots/presentation.gif)

### Architecture definitions and design patterns

**MVVM**  (Model View View Model) It was chosen MVVM instead of standard MVC from Apple because of the understanding that it is more sophisticated to build a software with a higher level of decoupling for increasing testability. 

**SingleTon** It was applied this pattern to keep a single instance for the client API, in this way the project has a centralized reference to get data from the server.

**Storyboard** Because the simplicity of this project the Storyboard fits well the needs. For more robust navigation, a new layer could be added to coordinate navigation in a more flexible way.  

**com.heuristisk.TMDbClient**  In order to decouple the networking logic from the project, it was built a framework. There are some PODS to get data from TMDb, I preferred to build my own to demonstrate how I am used to consuming data from remote API.
 

### Unit tests

For testing the **com.heuristisk.TMDbClient** framework it was written some test cases to coverage *88,79%* of code.

![Screenshot image](https://github.com/heuristisk/hkSymposium/blob/development/hkSymposium/resource/screenshots/unit.test.01.png?raw=true)

![Screenshot image](https://github.com/heuristisk/hkSymposium/blob/development/hkSymposium/resource/screenshots/unit.test.02.png?raw=true)

### How to build

Just clone the repository, run **pod install** and open the workspace project and execute the project.

### Dependencies - PODS

* **SwiftLint** - Used to keep the code standardized.
* **Alamofire** - Used to simplify the networking calls.
* **AlamofireObjectMapper** - Used to simplify the JSON parsing. 
* **Kingfisher** - Used to apply cache on download images and loading it asynchronously from the internet. 
*  **NVActivityIndicatorView** - Used to present a loader screen for improving the user experience.

### Improvements

* Unit testing for 100% of code coverage
* Layout
* UI Testing
* Build settings for some environments such as development, homolog, and production. 




