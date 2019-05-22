
# Careem-Test-Imdb
- A Careem-Test App. Displays movies data fetched from themoviedb.org API.


### Installing
- Open Terminal and run following command to install pods 
```
$ pod install
```

## Develope On
- Swift 4.2
- XCode 10.1

## Features
- Upcoming movies information.
- Endless Scrolling (Pagination based on themoviedb.org api data)
- Movie details (e.g. Poster, Rating, Language, Release Date, Overview)


## Technical Notes

### Architecture
- Architecture Used MVVM-C along with Builder
- Builder surves the modules construction prupose.
- Coordinator is used for navigation.
- Closure Bindind is used to Update View 

### Code Structure
Code has been strucutred into seven main categories, App, Scenes,Common,Resources,Services and Networking Files:
- App Group contain (AppDelegate)
- Scenes Group contain (MVVM files for Features)
- Resources Group contains (Assets, Info.plist, Assets, Launch Screen)
- Services Group contains (Services Uses in Features)
- Networking Group contain (Networking Layer on UrlSession )

### Code Coverage
- Test cases for each module, logic and services are provided.
- Code Coverage is upto 81%.

### Third Party
- Kingfisher (For downloading and caching images)
- SVProgressHUD (For displaying loader)


## Authors

* **Ali Akhtar** - (https://github.com/aliakhtar49)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


