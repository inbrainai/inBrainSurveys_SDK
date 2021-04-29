# InBrainSurveys SDK

Survey library to monetize your mobile app, provided by inBrain.ai.\
Please, check the **InBrainSurveys_Demo** app for getting integration example.

# Requirements
* iOS 10.0+ / Catalyst (macOS 10.15.1+)
* Swift 4.2+
* Xcode 11.3.1+

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
Add **import InBrainSurveys_SDK_Swift** to begin using SDK in your code.

Please, visit [CocoaPods](https://cocoapods.org) website for additional information.

### Manual
Drag and drop the **InBrainSurveys_SDK_Swift.xcframework** file into the same folder level as your *[AppName].xcodeproj* or *[AppName].xworkspace* file. 

**Next...**
Visit your app’s ***Target*** in the Project Settings and Choose the ***General*** tab.
Scroll down until you hit the ***Frameworks, Libraries and Embedded Content*** section… 
1) Press ‘+’ to Locate the **InBrainSurveys_SDK_Swift.framework** file in your file hierarchy.
2) Once selected, press "Add";
3) Check that "Embed" option is "Embed & Sing". In case of "Don Not Embed" chosen - the app will crash with error 
```
dyld: Library not loaded: @rpath/libswiftCore.dylib ...
```

# Configuration

InBrain SDK configuration pretty simple and can be completed att app launch or before SDK using. Bellow the proposed way how to setup InBrain SDK properly:
- Set API keys and reward callback target **setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool)** just after app launch;
- Set **inBrainDelegate** if you would like to receive an events;
- Set **userID** using **inBrain.set(userID: "userID")** function just you get it. If no **userID** provided - **UIDevice.current.identifierForVendor** will be used instead.

**API Client** and **API Secret** provided by InBrain; \
**isS2S** -  Is your app enabled with Server-to-Server(S2S) callbacks? Set to true if so, false if no server architecture.

Main setup completed and InBrain WebView can be shown. The additional config oprions may be found bellow.

# Usage

## Regular surveys 
For best user experience InBrain recommend to check is any surveys available before showing WebView. It can be done using 
**checkForAvailableSurveys(completion: @escaping ((_ hasSurveys: Bool, _ error: Error?) -> (Void)** method.

InBrain provides 2 options for present InBrain WebView:
1) Using  **showSurveys()** function. In this case InBrain will try to get top UIViewController from the hierarchyю If the SDK unable to get top UIViewController - message at the console will be shown;
2) Using  **showSurveys(from viewController: UIViewController)**

Sample code:
```
import InBrainSurveys_SDK_Swift

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

There a few steps to use InBrain Native Surveys:
1) Set **InBrain.shared.nativeSurveysDelegate**;
2) Fetch Native Surveys using **InBrain.shared.getNativeSurveys()** function;
3) Receive Native Surveys using **nativeSurveysReceived(_ surveys: [InBrainNativeSurvey])** function of nativeSurveysDelegate and show them to the user;
4) Once user choosed some survey - present InBrain WebView using **showNativeSurveyWith(nativeId: String)** or **showNativeSurveyWith(nativeId: String, from viewController: UIViewController)** function.

**Please, note:** SDK provides new portion of Native Surveys in a next cases:
- If **InBrain.shared.getNativeSurveys()** called;
- After user completed some of Native Surveys, received before.

Sample code:
```
import InBrainSurveys_SDK_Swift

class NativeSurveysViewController: UIViewController {
    
    let inBrain: InBrain = InBrain.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inBrain.setInBrain(apiClientID: "apiClientID",
                           apiSecret: "apiSecret",
                           isS2S: false)
        
        inBrain.set(userID: "userID")

        inBrain.nativeSurveysDelegate = self
        inBrain.getNativeSurveys()
    }
}

//MARK: - NativeSurveyDelegate
extension NativeSurveysViewController: NativeSurveyDelegate {
    func nativeSurveysLoadingStarted() {
        //Show some activity to the user while surveys loading is in process
    }

    func nativeSurveysReceived(_ surveys: [InBrainNativeSurvey]) {
        //Cache surveys and show them to the user
    }
    
    func failedToReceiveNativeSurveys(error: Error) {
        //Handle error depends on app logic
    }

}

``` 
**Please, note:** SDK should be configured *before* using Regular or Native Surveys.

# Advanced Usage
To add session tracking and/or to provide demographic data to your inBrainSurveys session utilize the **setInBrainValuesFor(sessionID: String, dataOptions: [[String : Any]]?)**

```
let data: [[String : Any]] = [["gender": "male"], ["age" : 34]]
inBrain.setInBrainValuesFor(sessionID: "testing33_Session", dataOptions: data)
```
**Please, note:** All the configs should be done before showing the surveys, or it will have no effect.

## Reward Hooks For Server2Server Apps
You can add your callback in your dashboard and test the response!\
If you need any assistance in getting your callback working properly, please email us at [dev@inbrain.ai](dev@inbrain.ai)

## Reward Hooks For Serverless Apps
In order to receive rewards earned from inBrain - needs to set *InBrainDelegate*  and implement method **didReceiveInBrainRewards(rewardsArray: [InBrainReward])**.


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

Rewards that have been processed **must** be confirmed with InBrain. To do this, use the ***InBrain.confirmRewards(txIDArray: [Int])*** function to confirm the acceptance of reward data.

This call should **always** be made following reward data processing.

## inBrain Functions

**setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool)**\
**setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool, userID: String)** \
**setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool, userID: String?, language: String)**
* Initial config of InBrain SDK

**set(userID: String?)**
* Provides and app userID to InBrain SDK;
* If no **userID** provided - **UIDevice.current.identifierForVendor** will be used instead.

**setInBrainValuesFor(sessionID: String, dataOptions: [[String : Any]]?)**
* Supported dataOptions keys "age" & "gender"

**showSurveys()** \
**showSurveys(from viewController: UIViewController)**
* Presents the InBrain WebView with configuration, provided before.
* Please, note:  SDK should be configured before showing the surveys, or it will have no effect.

**showNativeSurveyWith(id: String)** \
**showNativeSurveyWith(id: String, from viewController: UIViewController)**
* Presents the InBrain Native Survey with configuration, provided before.
* Please, note:  SDK should be configured before showing the survey, or it will have no effect.

**getRewards() (Useful for server less app)**
* InBrainDelegate must be set and implementation of inBrainRewardsReceived(rewardsArray: [InBrainReward]) function must be available to receive reward data.
* Stand alone function to explicitly call for rewards within the app code 

**confirmRewards(txIDArray: [Int]) (Useful for server less app)**
* Necessary call to confirm processed reward data
* Pass array of reward transactionIDs as function parameter 

## Language
By default, device's locale's language will be used. If you want to change it, you need to call
```
inBrain.setLanguage("en-us")
```
Accepted languages: `"de-de"`, `"en-au"`, `"en-ca"`, `"en-gb"`, `"en-in"`, `"en-us"`, `"es-es"`, `"es-mx"`, `"es-us"`, `"fr-ca"`, `fr-fr"`, `"fr-br"`

### InBrainDelegate functions
***didReceiveInBrainRewards(rewardsArray: [InBrainReward])***
* This delegate function provides an array of InBrainReward objects

***didFailToReceiveRewards(error: Error)***
* This delegate function provides an error if *getRewards()* failed

***surveysClosed()***
* This delegate function calls back whenever the InBrainWebView is dismissed

***surveysClosedFromPage()***
* This delegate function calls back whenever the InBrainWebView is dismissed from special web page placement

### nativeSurveysDelegate functions
***func nativeSurveysLoadingStarted()***
* Сalled just after loading of NativeSurveys started.

***nativeSurveysReceived(_ surveys: [InBrainNativeSurvey])***
* Provides fresh portion of Native surveys.

***failedToReceiveNativeSurveys(error: Error)***
* Called if loading of Native Surveys failed

## Customize inBrain

In order to customize InBrain WebView call these functions in code prior to showing InBrain WebView

**setNavigationBarTitle(_ title: String)**
* Set title for InBrain WebView controller

**setNavigationBarConfig(_ config: InBrainNavBarConfig)**
* Customize InBrain's UINavigationBar 
* Please, note: color values should be in sRGB (Device RGB) profile
```
let config = InBrainNavBarConfig(backgroundColor: UIColor(hex: "00a5ed"), buttonsColor: .white,
                                       titleColor: .white, isTranslucent: false, hasShadow: false)
inBrain.setNavigationBarConfig(config)
```

**setStatusBarConfig(_ config: InBrainStatusBarConfig)**
* Customize Status Bar 
* Please, note: In order to customize status bar - needs to set View controller-based status bar appearance to YES

```
let statusBarConfig = InBrainStatusBarConfig(statusBarStyle: .lightContent, hideStatusBar: false)
inBrain.setStatusBarConfig(statusBarConfig)
```

# Side note - Things to double check:
* Be sure your configured InBrain SDK with proper values; 
* Ensure that you are set *InBrainDelegate* and implemented *didReceiveInBrainRewards()* in case of Serverless app.

# Troubleshooting
## Library not loaded
In case of Objective-C projects building for simulator may be failed with error:
```
  dyld: library not loaded: @rpath/libswiftCore.dylid
  Library not loaded: @rpath/libswiftCore.dylib
    Referenced from: .../Debug-iphonesimulator/InBrainSurveys_SDK_Swift.framework/InBrainSurveys_SDK_Swift
    Reason: no suitable image found.  Did find:
      /usr/lib/swift/libswiftCore.dylib: mach-o, but not built for iOS simulator
```
To resolve this issue open Project -> Target -> Build Settings -> set **Always Embed Swift Standard Libraries** to **YES**.

## No such module 
Xcode 12 introduced architecture-related updates, which caused to `No such module `InBrainSurveys_SDK_Swift`` error alongside with `[CP] Unable to find matching .xcframework slice in 'path_to_InBrainSurveys_SDK InBrainSurveys_SDK_Swift framework ios-i386_x86_64-simulator ios-armv7_arm64' for the current build architectures (arm64 x86_64)` warning.

In order to fix the issue for Xcode 12 - please, add following lines to the .podfile:
```
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      #config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
     end
  end
end
```

This issue not fixed at our side in order to keep Xcode 11 compatible.
