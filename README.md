# inBrainSurveys_SDK

Survey library to monetize your mobile app, provided by inBrain.ai

# Requirements
* iOS 10.0
* Swift 4.2
* Xcode 11+

# Installation
### CocoaPods
Add to your project's Podfile
  
Podfile Example:
```
target "AppName" do
     use_frameworks!
     pod 'InBrainSurveys'
end
```

Then, from Terminal within the project folder, run
```
pod install
```
Once *pod install* command is complete, from now on open .xcworkspace file for your project.

Add **import InBrainSurveys_SDK_Swift** to begin using SDK in your code

### Manual
Drag and drop the **InBrainSurveys_SDK_Swift.xcframework** file into the same folder level as your *[AppName].xcodeproj* or *[AppName].xworkspace* file. 

**Next...**
Visit your app’s ***Target*** in the Project Settings and Choose the ***General*** tab.
Scroll down until you hit the ***Embedded Binaries*** section… 
1) Press ‘+’ to Locate the **InBrainSurveys_SDK_Swift.framework** file in your file hierarchy.
2) Once selected, add to your Embedded Binaries.

# Objective-C Installation
Sometimes Xcode buildings of Objective-C projects for simulator fails with error:
```
  dyld: library not loaded: @rpath/libswiftCore.dylid
  Library not loaded: @rpath/libswiftCore.dylib
    Referenced from: .../Debug-iphonesimulator/InBrainSurveys_SDK_Swift.framework/InBrainSurveys_SDK_Swift
    Reason: no suitable image found.  Did find:
      /usr/lib/swift/libswiftCore.dylib: mach-o, but not built for iOS simulator
```
To resolve this issue open to Project -> Target -> Build Settings -> set **Always Embed Swift Standard Libraries** to **YES**.

# Configuration

InBrain SDK configuration pretty simple and can be completed att app launch or before SDK using. Bellow the proposed way how to setup InBrain SDK properly:
- Set API keys and rewards callback target **setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool)** just after app launch;
- Set **inBrainDelegate** if you would like to receive an events;
- Set **userID** using **inBrain.set(userID: "userID")** function just you get it. If no **userID** provided - **UIDevice.current.identifierForVendor** will be used instead.

**API Client** and **API Secret** provided by InBrain;
**isS2S** -  Is your app enabled with Server-to-Server(S2S) callbacks? Set to true if so, false if no server architecture.

Main setup completed and InBrain WebView can be shown. The additional config oprions may be found bellow.

# Usage

There 2 options to present InBrain WebView:
1) Using  **showSurveys()** function. In this case InBrain WebView will be presented from *inBrainDelegate*, if it's an UIViewController subclass, or from *UIApplication.shared.keyWindow?.rootViewController* if not. If the SDK unable to get UIViewController using both this options - message at the console will be shown;
2) Using  **showSurveys(from viewController: UIViewController)**.

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
        inBrain.showSurveys() 
    }

}

``` 
**Please, note:** SDK should be configured before showing the surveys, or it will have no effect.

# Advanced Usage
To add session tracking and/or to provide demographic data to your inBrainSurveys session utilize the **setInBrainValuesFor(sessionID: String, dataOptions: [[String : Any]]?)**

```
let data: [[String : Any]] = [["gender": "male"], ["age" : 34]]
inBrain.setInBrainValuesFor(sessionID: "testing33_Session", dataOptions: data)
```
**Please, note:** All the configs should be done before showing the surveys, or it will have no effect.

## Reward Hooks For Server2Server Apps
You can add your callback in your dashboard and test the response!

If you need any assistance in getting your callback working properly, please email us at [dev@inbrain.ai](dev@inbrain.ai)

## Reward Hooks For Serverless Apps
Even without a unique user ID, we’ll pass along the reward value for you to add. 

In order to receive rewards earned from inBrain - needs to set *InBrainDelegate*  and implement method **didReceiveInBrainRewards(rewardsArray: [InBrainReward])**.


### Handling Rewards Received & Confirming Received Rewards:

```
class ViewController: UIViewController, InBrainDelegate {
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

## Ad Hoc inBrain Functions

**setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool)**
**setInBrain(apiClientID: String, apiSecret: String, isS2S: Bool, userID: String)**
* Initial config of InBrain SDK

**set(userID: String?)**
* Provides and app userID to InBrain SDK;
* If no **userID** provided - **UIDevice.current.identifierForVendor** will be used instead.

**setInBrainValuesFor(sessionID: String, dataOptions: [[String : Any]]?)**
* Supported dataOptions keys "age" & "gender"

**showSurveys()**
**showSurveys(from viewController: UIViewController)**
* Presents the InBrain WebView with configuration, provided before.
* Please, note:  SDK should be configured before showing the surveys, or it will have no effect.

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

## Customize inBrain

In order to customize InBrain WebView call these functions in code prior to calling *showSurveys()*

**setInBrainWebViewTitle(toString: String)**
* Presents the InBrain WebView with the title string which is provided by the toString parameter

**setInBrainWebViewNavBarColor(toColor: UIColor)**
* Presents the InBrain WebView with the navigationBar displaying the toColor parameter as its background color

**setInBrainWebViewNavButtonColor(toColor: UIColor)**
* Presents the InBrain WebView with the navigationButtons displaying the toColor parameter as its text color

# Side note - Things to double check:
* Be sure your configured InBrain SDK with proper values; 
* Ensure that you are set *InBrainDelegate* and implemented *didReceiveInBrainRewards()* in case of Serverless app.


