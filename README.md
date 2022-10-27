# InBrainSurveys

Survey library to monetize your mobile app, provided by inBrain.ai.\
Please, check the **InBrainSurveys_Demo** app for getting integration example.

# Requirements
* iOS 12.0+ / Catalyst(macOS 10.15.1+), iOS 13.1+
* Swift 5.0+
* Xcode 13+

# Installation
### CocoaPods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. To integrate InBrainSurveys into your Xcode project using CocoaPods, specify it in your `Podfile`:  
```
pod 'InBrainSurveys'
```

Then, from Terminal within the project folder, run
```
pod install
```

Once *pod install* command is complete, from now on open .xcworkspace file for your project.\
Add `import InBrainSurveys` to begin using SDK in your code.

Please, visit [CocoaPods](https://cocoapods.org) website for additional information.

### Manual
Drag and drop the **InBrainSurveys.xcframework** file into the same folder level as your *[AppName].xcodeproj* or *[AppName].xworkspace* file;\
Then open your app’s ***Target*** in the Project Settings and Choose the ***General*** tab.
Scroll down until you hit the ***Frameworks, Libraries and Embedded Content*** section… 
1) Press ‘+’ to Locate the **InBrainSurveys.framework** file in your file hierarchy.
2) Once selected, press "Add";
3) Check that "Embed" option is "Embed & Sing". In case of "Don Not Embed" chosen - the app will crash with error 
```
dyld: Library not loaded: @rpath/libswiftCore.dylib ...
```

# Configuration

The SDK configuration is pretty simple and can be completed at app launch or before use the SDK. Bellow the proposed way how to setup InBrainSurveys properly:
- Set API keys and reward callback target `setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool)` just after app launch;
- Set **inBrainDelegate** if you would like to receive an events;
- Set **userID** using **inBrain.set(userID: "userID")** function just you get it. If no **userID** provided - **UIDevice.current.identifierForVendor** will be used instead.

**API Client** and **API Secret** provided by InBrain; \
**isS2S** -  Is your app enabled with Server-to-Server(S2S) callbacks? Set to true if so, false if no server architecture.

Main setup completed and InBrainSurveys is ready to use. Additional config oprions may be found bellow.

# Usage

## Survey Wall 
For best user experience we recommend to check are the surveys available prior to call `showSurveys()`. That can be done using 
`checkForAvailableSurveys(completion: @escaping ((_ hasSurveys: Bool, _ error: Error?) -> (Void)` method.

InBrainSurveys provides 2 options to show **Survey Wall**:
1) Using  `showSurveys()` function. In this case InBrain will try to get top UIViewController from the hierarchy. If the SDK unable to get top UIViewController - message at the console will be shown;
2) Using  `showSurveys(from viewController: UIViewController)`

Sample code:
```
import InBrainSurveys

class ViewController: UIViewController {
    
    let inBrain: InBrain = InBrain.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inBrain.setInBrain(apiClientID: "apiClientID",
                           apiSecret: "apiSecret",
                           isS2S: false)
        
        inBrain.inBrainDelegate = self
        inBrain.set(userID: "userID")

    }
    
    @IBAction func showInBrain(_ sender: UIButton) {
        inBrain.checkForAvailableSurveys { [weak self] hasSurveys, _  in
            guard hasSurveys else { return }
            self?.inBrain.showSurveys()
        }
    }
}

``` 
## Native surveys

InBrainSurveys SDK provides two options to handle **Native Surveys**, please use the best fits for you.\
**Imoprtant:** After survey completed - it becames invalid and cannot be opened again.

First method - using *NativeSurveysDelegate*, there are few steps to use it:
1) Set **InBrain.shared.nativeSurveysDelegate**;
2) Call `InBrain.shared.getNativeSurveys(filter:)` function to fetch Native Surveys;
3) Handle the surveys using `nativeSurveysReceived(\_ surveys: [InBrainNativeSurvey], filter: InBrainSurveyFilter?)` function of nativeSurveysDelegate and show them to the user;
4) Once user selected some survey - call `showNativeSurveyWith(id:serachId:from:)` or `showNativeSurvey(_ survey: from:)` function to open the survey.


**Important notes:**
- Please, take care about refreshing surveys with appropriate filter(s). We are proposing to fetch **Native Surveys** each time after **InBbrainWebView** closed and some survey(s) completed;
- The same **NativeSurvey** may fit a few filters at the same time. If you are using a few filters - please, refresh the surveys for each filter where the survey presented;
- If you are using **SurveyWall** as well - please take care about refreshing **Native Surveys** after some survey(s) completed.
Use `surveysClosed(byWebView: Bool, completedSurvey: Bool)` method of **InBrainDelegate** to detect **InBbrainWebView** dismissal

Sample code:
```
import InBrainSurveys

class NativeSurveysViewController: UIViewController {
    
    let inBrain: InBrain = InBrain.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inBrain.setInBrain(apiClientID: "apiClientID",
                           apiSecret: "apiSecret",
                           isS2S: false)
        
        inBrain.set(userID: "userID")

        inBrain.nativeSurveysDelegate = self
        
        let filter = InBrainSurveyFilter(placementId: "placementId",
                                         categories: [.business],
                                         excludedCategories: nil)
        inBrain.getNativeSurveys(filter: filter)
    }
}

//MARK: - NativeSurveyDelegate
extension NativeSurveysViewController: NativeSurveyDelegate {
    func nativeSurveysLoadingStarted(filter: InBrainSurveyFilter?) {
        //Show some activity to the user while surveys loading is in process
    }

    func nativeSurveysReceived(_ surveys: [InBrainNativeSurvey], filter: InBrainSurveyFilter?) {
        //Cache surveys and show them to the user
    }
    
    func failedToReceiveNativeSurveys(error: Error, filter: InBrainSurveyFilter?) {
        //Handle error depends on app logic
    }
}

``` 

The second option - is to get **Native Surveys** with callbacks:
1) Fetch **Native Surveys** using `InBrain.shared.getNativeSurveys(filter:success:failed)` function and show them to the user;
2) Once user selected some survey - call `showNativeSurveyWith(id:serachId:from:)` or `showNativeSurvey(_ survey: from:)` function to open the survey.

**Important notes:**
- Please, take care about refreshing surveys with appropriate filter(s). We are proposing to fetch **Native Surveys** each time after **InBbrainWebView** closed and some survey(s) completed;
- The same **NativeSurvey** may fit a few filters at the same time. If you are using a few filters - please, refresh the surveys for each filter where the survey presented;
- If you are using **Survey Wall** as well - please take care about refreshing **Native Surveys** after some survey(s) completed.
Use `surveysClosed(byWebView: Bool, completedSurvey: Bool)` method of **InBrainDelegate** to detect **InBbrainWebView** dismissal


**Please, note:** SDK should be configured *before* using Survey Wall or Native Surveys.

# Advanced Usage

## Reward Hooks For Server2Server Apps
You can add your callbacks in the [Dashboard](https://publisher.inbrain.ai/) and test the response!\
If you need any assistance in getting your callback working properly, please email us at [dev@inbrain.ai](dev@inbrain.ai)

## Reward Hooks For Serverless Apps
In order to receive rewards earned from inBrain - plesae, set **InBrainDelegate** `InBrain.shared.inBrainDelegate = self` 
and implement method `didReceiveInBrainRewards(rewardsArray:)`. The method called by the SDK each time the **InBbrainWebView** closed and some survey(s) completed.

### Handling Rewards Received & Confirming Received Rewards:

```
extension ViewController: InBrainDelegate {
    func didReceiveInBrainRewards(rewardsArray: [InBrainReward]) {
        var idsToConfirm : [Int] = []
        var points: Float = 0
        
        for reward in rewardsArray {
            points +=  reward.amount
            idsToConfirm.append(reward.transactionId)
        }
        pointsLabel.text = "Total Points: \(points)"

        inBrain.confirmRewards(txIdArray: idsToConfirm)
    }
}
```
### Confirm Received Rewards (sample code above)

Rewards that have been processed **must** be confirmed with InBrain. To do this call `InBrain.confirmRewards(txIDArray:)` function to confirm the acceptance of reward data.

This call should **always** be made following reward data processing.

## Currency Sale
The SDK provides an option to get active currency sale. That may be done with method `getCurrencySale(success:failed:)`:
```
InBrain.shared.getCurrencySale(success: { [weak self] sale in
  // Show the info to the user
            }, failed: { error in
 // Handle the error
            })
```

## Session & User Data 
To add session tracking and/or to provide demographic data to your inBrainSurveys session utilize the `setInBrainValuesFor(sessionID: String, dataOptions: [[String : Any]]?)`:

```
let data: [[String : Any]] = [["gender": "male"], ["age" : 34]]
inBrain.setInBrainValuesFor(sessionID: "testing33_Session", dataOptions: data)
```
**Please, note:** All the configs should be done before showing the surveys, or it will have no effect.

## Language
By default, device's locale's language will be used. If you want to change it - pls, call `inBrain.setLanguage(_ language:"en-us")`
Accepted languages: `"de-de"`, `"en-au"`, `"en-ca"`, `"en-gb"`, `"en-in"`, `"en-us"`, `"es-es"`, `"es-mx"`, `"es-us"`, `"fr-ca"`, `fr-fr"`, `"fr-br"`


## Customize inBrain

InBrainSurveys provides to customize some UI elements of **InBrainWebView**. In order to do that - call these functions prior to showing **InBrainWebView**:

`setNavigationBarTitle(_ title: String)` - Set title of **InBrainWebView**

`setNavigationBarConfig(_ config: InBrainNavBarConfig)` - Customize **UINavigationBar** of **InBrainWebView**. Please, note: color values should be in sRGB (Device RGB) profile
```
let config = InBrainNavBarConfig(backgroundColor: UIColor(hex: "00a5ed"), buttonsColor: .white,
                                       titleColor: .white, isTranslucent: false, hasShadow: false)
inBrain.setNavigationBarConfig(config)
```

`setStatusBarConfig(_ config: InBrainStatusBarConfig)` - Customize **Status Bar**. Please, note: In order to customize status bar - needs to set **View controller-based** status bar appearance to **YES**

```
let statusBarConfig = InBrainStatusBarConfig(statusBarStyle: .lightContent, hideStatusBar: false)
inBrain.setStatusBarConfig(statusBarConfig)
```

# Migration
## InBrainSurveys 2.0 Migration Guide
InBrainSurveys 2.0.0 is the latest major release of InBrainSurveys, Survey library to monetize your mobile app, provided by inBrain.ai. As a major release, following Semantic Versioning conventions, 2.0 introduces several methods changes that one should be aware of.

### SDK renaming
New name of the SDK is **InBrainSurveys**.
As a result or renaming - build will be failed with errors. Possible errors using CocoaPods and manual installation: 
- **No such module 'InBrainSurveys_SDK_Swift'** error \
  Solution - is to replace `import InBrainSurveys_SDK_Swift` with  `import InBrainSurveys`
- **InBrainSurveys_SDK_Swift/InBrainSurveys_SDK_Swift.h' file not found** error \
  Solution - is to replace `#import <InBrainSurveys_SDK_Swift/InBrainSurveys_SDK_Swift.h>` with `#import <InBrainSurveys/InBrainSurveys.h>`.
 
Possible errors using Manual installation: 
- **There is no XCFramework found at '.../InBrainSurveys_SDK_Swift.xcframework'** error \
  Solution - it ro remove reference to **InBrainSurveys_SDK_Swift.xcframework** from your project and add **InBrainSurveys.xcframework** instead and to check that "Embed" option is "Embed & Sing".\
Highly recommended to clean the build folde (cmd+shift+k) and Derived data after those updates.

### New entities
- **InBrainSurveyCategory** - enum, represents all the supported categories;
- **InBrainSurveyFilter** - struct to specify survey fetching rules. It provides and option to get Native Surveys filtered by **placement**, **categories** and **excluded categories**. All the options may be used separated or simultaneously, the single limitation - is categories and excluded categories shouldn't intersect.

### Updated methods

#### InBrain
- **getNativeSurveys(placementID: String?)** \
 Changed to: `getNativeSurveys(filter: InBrainSurveyFilter?)`
- **getNativeSurveys(placementID: String?, success: ([InBrainNativeSurvey]) -> (), failed: ErrorCallback)** \
 Changed to: `getNativeSurveys(filter: InBrainSurveyFilter?, success: ([InBrainNativeSurvey]) -> (), failed: ErrorCallback)`
- **showNativeSurveyWith(id: String, placementId: String?, from viewController: UIViewController?)** \
 Changed to: `showNativeSurveyWith(id: String, searchId: String, from: UIViewController?)`

#### NativeSurveyDelegate
- **nativeSurveysLoadingStarted(placementId: String?)** \
  Changed to: `nativeSurveysLoadingStarted(filter: InBrainSurveyFilter?)`
- **nativeSurveysReceived(\_ surveys: [InBrainNativeSurvey], placementId: String?)** \
  Changed to: `nativeSurveysReceived(_ surveys: [InBrainNativeSurvey], filter: InBrainSurveyFilter?)`
- **failedToReceiveNativeSurveys(error: Error, placementId: String?)** \
  Changed to: `failedToReceiveNativeSurveys(error: Error, filter: InBrainSurveyFilter?)`

### Other changes
- `NativeSurvey`'s `placementId` property replaced with `searchId`;
- added `categories` (`categoryIds` for Obj-C) property to `NativeSurvey`. 

# Full list of SDK's function
## InBrain Functions

`setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool)`\
`setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool, userID: String)`
* Initial config of InBrain SDK

`set(userID: String?)`
* Provides and app userID to InBrain SDK;
* If no **userID** provided - **UIDevice.current.identifierForVendor** will be used instead.

`setInBrainValuesFor(sessionID: String, dataOptions: [[String : Any]]?)`
* Supported dataOptions keys "age" & "gender"

`showSurveys()` \
`showSurveys(from viewController: UIViewController?)`
* Presents the **Survey Wall** with configuration, provided before.
* Please, note:  SDK should be configured before showing the surveys, or it will have no effect.
* Important: If you are using **Native Surveys** - please, take care about refreshing them after some survey(s) completed. Additional details may be found at **Native Surveys** section description.

`showNativeSurveyWith(id: String, searchId: String, from viewController: UIViewController?)` \
`showNativeSurvey(_ survey: InBrainNativeSurvey, from viewController: UIViewController?)`
* Presents the **Native Survey** with configuration, provided before.
* Please, note:  SDK should be configured before showing the survey, or it will have no effect.
* Important: If you are using **Native Surveys** - please, take care about refreshing them after some survey(s) completed. Additional details may be found at **Native Surveys** section description.

`getRewards()` \
`getRewards(success: @escaping ([InBrainReward]) -> (), failed: @escaping ErrorCallback)`
* Deliver the unconfirmed rewards to `inBrainRewardsReceived(rewardsArray:)` function of **InBrainDelegate** or to callback closure, depends on the used function.

`confirmRewards(txIDArray: [Int])`
* Necessary call to confirm processed reward data;
* Pass array of reward transactionIDs as function parameter.

### InBrainDelegate functions
`didReceiveInBrainRewards(rewardsArray: [InBrainReward])`
* This delegate function provides an array of InBrainReward objects

`didFailToReceiveRewards(error: Error)`
* This delegate function provides an error if *getRewards()* failed

`surveysClosed(byWebView: Bool, completedSurvey: Bool)`
* This delegate function calls back whenever the InBrainWebView is dismissed. If `byWebView == true` - dismissed automatically by the WebView; If `byWebView == false` - dismissed by the user; `completedSurvey == true` - some survey(s) completed (succeded or disqualified).

### NativeSurveysDelegate functions
`func nativeSurveysLoadingStarted(filter: InBrainSurveyFilter?)`
* Сalled just after loading of Native Surveys started.

`nativeSurveysReceived(_ surveys: [InBrainNativeSurvey], filter: InBrainSurveyFilter?)`
* Provides fresh portion of Native surveys.

`failedToReceiveNativeSurveys(error: Error, filter: InBrainSurveyFilter?)`
* Called if loading of Native Surveys failed


# Side note - Things to double check:
* Be sure your configured InBrain SDK with proper values; 
* Ensure that you are set *InBrainDelegate* and implemented *didReceiveInBrainRewards()* in case of Serverless app.

# Troubleshooting
## Library not loaded
In case of Objective-C projects building may be failed with error:
```
  dyld: library not loaded: @rpath/libswiftCore.dylid
  Library not loaded: @rpath/libswiftCore.dylib
    Referenced from: .../Debug-iphonesimulator/InBrainSurveys.framework/InBrainSurveys
    Reason: no suitable image found.  Did find:
      /usr/lib/swift/libswiftCore.dylib: mach-o, but not built for iOS simulator
```
To resolve this issue open Project -> Target -> Build Settings -> set **Always Embed Swift Standard Libraries** to **YES**.

## M1/M2 Troubles
The SDK built with support of M1 architecture, so no troubles are expected. However if you will face some - we are proposing to try the next steps:
1) Open Terminal;
2) Install [Homebrew](https://brew.sh/);
3) Remove currently installed CocoaPods - `sudo gem uninstall cocoapods`;
4) Install CocoaPods using Homebrew - `brew install cocoapods`;
5) Go to project's folder at Terminal;
6) Remove pods from the project - `pod deintegrate`;
7) Clean the project `cmd+shift+k` at Xcode;
8) Clean Derived data;
9) Install the pods - `pod install` at Terminal.

Now the problem should be solved.
