# hkSymposium
### Overview
It is a demo project for evaluation purposes. It is an app for cinephiles and movie hobbyists to get an update about upcoming movies, based on The Movie Database (TMDb) API.

### Screenshot

![Screenshot image](https://github.com/heuristisk/hkSymposium/blob/development/hkSymposium/resource/screenshots/screenshot.png?raw=true)

### Navigation animation

-[Screenshot image](https://github.com/heuristisk/hkSymposium/blob/development/hkSymposium/resource/screenshots/presentation.gif)

### Architecture definitions and design patterns

**MVVM**  (Model View View Model) It was chosen MVVM instead of standard MVC from Apple because of the understanding that it is more sophisticated to build a software with a higher level of decoupling for increasing testability. 

**SingleTon** It was applied this pattern to keep a single instance for the client API, in this way the project has a centralized reference to get data from the server.

**Storyboard** Because the simplicity of this project the Storyboard fits well the needs. For more robust navigation, a new layer could be added to coordinate navigation in a more flexible way.  

**com.heuristisk.TMDbClient**  In order to decouple the networking logic from the project, it was built a framework. There are some PODS to get data from TMDb, I preferred to build my own to demonstrate how to consume data from remote API.
 

### Unit tests

Foram escritos teste unitários para garantir integridade de funcionamento das principais funções e cobertura de **79,46%** do código, tanto quanto testar cenários alternativos e provocar situação de erros para avaliar como o código se comporta em tais condições.

![Screenshot image](https://gitlab.com/anderson.gusmao/evaluation/raw/master/fastshop/resources/markdown/coverage.png)




