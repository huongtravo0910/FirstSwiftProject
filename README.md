# Marvel API App Example
This is my first swift project, which uses Marvel API

##HOW TO USE

###Clone this repo
Choose a folder project in your system and switch in cd [folder path]
Clone the repo in your folder git clone https://github.com/huongtravo0910/MarvelAPIExample.git

###Create an dev account on Marvel web if you haven't had one yet
Sign up an account on `https://developer.marvel.com` .
Since you sign up successfully, you will be provided a public key and a private key. Go to my developer account page to get the keys. Then put the them into your code 

Now the app is ready to run.


###Run test by command line
* For all tests: 
```
xcodebuild test \
  -project Marvel_API_Ex_App.xcodeproj \
  -scheme Marvel_API_Ex_App \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 11,OS=14.4'
```

* For a specific test:
```
xcodebuild test \
  -project Marvel_API_Ex_App.xcodeproj \
  -scheme Marvel_API_Ex_App \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 11,OS=14.4' \
  -only-testing ComicUnitTests/ComicUnitTests/testLoadComicViewModelSuccessfully
```
The first `ComicUnitTests` is target name, the second `ComicUnitTests` is class name, and `testLoadComicViewModelSuccessfully` is a target function.