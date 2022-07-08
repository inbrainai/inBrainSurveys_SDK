// Generated by Apple Swift version 5.6.1 (swiftlang-5.6.0.323.66 clang-1316.0.20.12)
#ifndef INBRAINSURVEYS_SDK_SWIFT_SWIFT_H
#define INBRAINSURVEYS_SDK_SWIFT_SWIFT_H
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(ns_consumed)
# define SWIFT_RELEASES_ARGUMENT __attribute__((ns_consumed))
#else
# define SWIFT_RELEASES_ARGUMENT
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#if !defined(SWIFT_EXTERN)
# if defined(__cplusplus)
#  define SWIFT_EXTERN extern "C"
# else
#  define SWIFT_EXTERN extern
# endif
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import Foundation;
@import ObjectiveC;
@import UIKit;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="InBrainSurveys_SDK_Swift",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

@protocol InBrainDelegate;
@protocol NativeSurveyDelegate;
@class NSString;
@class InBrainNavBarConfig;
@class InBrainStatusBarConfig;
@class UIViewController;
@class InBrainNativeSurvey;
@class InBrainReward;
@class InBrainCurrencySale;

/// Main interface to communicate with the InBrain service.
SWIFT_CLASS("_TtC24InBrainSurveys_SDK_Swift7InBrain")
@interface InBrain : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) InBrain * _Nonnull shared;)
+ (InBrain * _Nonnull)shared SWIFT_WARN_UNUSED_RESULT;
@property (nonatomic, weak) id <InBrainDelegate> _Nullable inBrainDelegate;
@property (nonatomic, weak) id <NativeSurveyDelegate> _Nullable nativeSurveysDelegate;
@property (nonatomic, readonly) BOOL isOnScreen;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
/// Config inBrain at app launch using this method.
/// <ul>
///   <li>
///     The userID can be provided after auth, using <code>set(userID:)</code> method;
///   </li>
///   <li>
///     If userID not set (or empty) - <code>identifierForVendor</code> will be used.
///   </li>
/// </ul>
- (void)setInBrainWithApiClientID:(NSString * _Nonnull)apiClientID apiSecret:(NSString * _Nonnull)apiSecret isS2S:(BOOL)isS2S;
/// Config inBrain before <code>showSurveys</code> function call.
/// \param userID If userID not set (or empty) - <code>identifierForVendor</code> will be used;
///
- (void)setInBrainWithApiClientID:(NSString * _Nonnull)apiClientID apiSecret:(NSString * _Nonnull)apiSecret isS2S:(BOOL)isS2S userID:(NSString * _Nullable)userID;
/// Set userID to identify the user by the server.
/// <ul>
///   <li>
///     If userID not set (or empty) - <code>identifierForVendor</code> will be used.
///   </li>
/// </ul>
- (void)setWithUserID:(NSString * _Nullable)userID;
/// Set title before calling <code>showSurveys()</code>
- (void)setNavigationBarTitle:(NSString * _Nonnull)title;
/// Customize Navigation Bar before calling <code>showSurveys()</code>
- (void)setNavigationBarConfig:(InBrainNavBarConfig * _Nonnull)config;
/// Customize Status Bar before calling <code>showSurveys()</code>
/// In order to customize status bar - needs to set <code>View controller-based status bar appearance</code> to <code>YES</code>
- (void)setStatusBarConfig:(InBrainStatusBarConfig * _Nonnull)config;
/// Set values before calling <code>showSurveys()</code>
- (void)setInBrainValuesForSessionID:(NSString * _Nullable)sessionID dataOptions:(NSArray<NSDictionary<NSString *, id> *> * _Nullable)dataOptions;
/// Set language to be used. If not set - device language will be used.
/// Language should be in <code>xx-xx</code> format.
/// \param language Available languages are “de-de”, “en-au”, “en-ca”, “en-gb”, “en-in”, “en-us”, “es-es”, “es-mx”, “es-us”, “fr-ca”, fr-fr”, “fr-br”
///
- (BOOL)setLanguage:(NSString * _Nonnull)language error:(NSError * _Nullable * _Nullable)error;
/// Check are surveys available.
- (void)checkForAvailableSurveysWithCompletion:(void (^ _Nonnull)(BOOL, NSError * _Nullable))completion;
/// All the configs should be done <code>BEFORE</code> calling <code>showSurveys()</code>.
/// If you are using <em>NativeSurveys</em> (regardless of placementId) - please, take care about refreshing them after some survey(s) completed. Additional details may be found at <em>getNativeSurveys</em> function description.
/// \param viewController ViewController to present InBrain from. If no controller specified - InBrain will be presented from inBrainDelegate (if subclass of UIViewController) OR from UIApplication’s keyWindow.
///
- (void)showSurveysFrom:(UIViewController * _Nullable)viewController;
/// Can be used for surveys with and without <code>placementId</code> as well. All the configs should be done <code>BEFORE</code> calling <code>showSurveys()</code>.
/// After survey completed - it becames invalid and cannot be opened again. Please, ensure all the NativeSurveys updated after <em>InBrainWebView</em> closed. Additional details may be found at <em>getNativeSurveys</em> function description
/// \param survey Native survey to be opened
///
/// \param viewController ViewController to present InBrain from. If no controller specified - InBrain will be presented from inBrainDelegate (if subclass of UIViewController) OR from UIApplication’s keyWindow.
///
- (void)showNativeSurvey:(InBrainNativeSurvey * _Nonnull)survey from:(UIViewController * _Nullable)viewController;
/// All the configs should be done <code>BEFORE</code> calling <code>showSurveys()</code>.
/// After survey completed - it becames invalid and cannot be opened again. Please, ensure all the NativeSurveys updated after <em>InBrainWebView</em> closed. Additional details may be found at <em>getNativeSurveys</em> function description
/// \param placementId Identifer of place, survey linked to;
///
/// \param viewController ViewController to present InBrain from. If no controller specified - InBrain will be presented from inBrainDelegate (if subclass of UIViewController) OR from UIApplication’s keyWindow.
///
- (void)showNativeSurveyWithId:(NSString * _Nonnull)surveyId placementId:(NSString * _Nullable)placementId from:(UIViewController * _Nullable)viewController;
/// Request InBrainRewards from the server. Process the rewards within your app
/// and confirm it using <code>confirmRewards(txIdArray:)</code> function.
/// \param success Callback to be triggered just rewards fetched
///
/// \param failed Callback to be triggered in case of error
/// while fetching rewards
///
- (void)getRewardsWithSuccess:(void (^ _Nonnull)(NSArray<InBrainReward *> * _Nonnull))success failed:(void (^ _Nonnull)(NSError * _Nonnull))failed;
/// Request InBrainRewards from the server. Process the rewards within your app
/// and confirm it using <code>confirmRewards(txIdArray:)</code> function.
/// Result will be passed to <code>InBrainDelegate's</code>
- (void)getRewards;
/// Confirm rewards after processed by the app.
/// After rewards confirmed - they weren’t be returned by <code>getRewards()</code> method
/// \param txIdArray Rewards ids to be confirmed
///
- (void)confirmRewardsWithTxIdArray:(NSArray<NSNumber *> * _Nonnull)txIdArray;
/// Get information about active Currency Sale
- (void)getCurrencySaleWithSuccess:(void (^ _Nonnull)(InBrainCurrencySale * _Nullable))success failed:(void (^ _Nonnull)(NSError * _Nonnull))failed;
/// Get native surveys for the user. Result will be delivered to <code>NativeSurveyDelegate</code>.
/// After survey completed - it becames invalid and cannot be opened again.
/// In order to keep you with up-to-date surveys - SDK will provide a fresh portion of <em>NativeSurveys</em> for the same placementId, as completed survey has.
/// important:
/// Please, note:
/// <ul>
///   <li>
///     The same NativeSurvey may be related to different placements. If some survey appears at lists with different placementId - please take care about refreshing surveys for rest placements;
///   </li>
///   <li>
///     If you are using SurveyWall as well - please take care about refreshing NativeSurveys after some survey(s) completed.
///   </li>
/// </ul>
/// Use <em>surveysClosed(byWebView: Bool, completedSurvey: Bool)</em> method of <em>InBrainDelegate</em> to detect InBbrainWebView dismissal.
- (void)getNativeSurveysWithPlacementId:(NSString * _Nullable)placementId;
/// Get native surveys once.
/// After survey completed - it becames invalid and cannot be opened again. We are proposing to fetch <em>NativeSurveys</em> each time after <em>InBbrainWebView</em> closed and some survey(s) completed.
/// Please, use <em>surveysClosed(byWebView: Bool, completedSurvey: Bool)</em> method of <em>InBrainDelegate</em> to detect InBbrainWebView dismissal.
/// important:
/// The same NativeSurvey may be related to different placements. If some survey contains at lists with different placementId - surveys for each placement needs to be updated.
- (void)getNativeSurveysWithPlacementID:(NSString * _Nullable)placementID success:(void (^ _Nonnull)(NSArray<InBrainNativeSurvey *> * _Nonnull))success failed:(void (^ _Nonnull)(NSError * _Nonnull))failed;
/// Config inBrain before <code>showSurveys</code> function call.
/// \param userID If userID not set (or empty) - <code>identifierForVendor</code> will be used;
///
/// \param language Available languages are “de-de”, “en-au”, “en-ca”, “en-gb”, “en-in”, “en-us”, “es-es”, “es-mx”, “es-us”, “fr-ca”, fr-fr”, “fr-br”
///
- (void)setInBrainWithApiClientID:(NSString * _Nonnull)apiClientID apiSecret:(NSString * _Nonnull)apiSecret isS2S:(BOOL)isS2S userID:(NSString * _Nullable)userID language:(NSString * _Nonnull)language SWIFT_DEPRECATED_MSG("Please, use separate setLanguage(from:) function");
/// Set language to be used. If not set - device language will be used.
/// \param value Available languages are “de-de”, “en-au”, “en-ca”, “en-gb”, “en-in”, “en-us”, “es-es”, “es-mx”, “es-us”, “fr-ca”, fr-fr”, “fr-br”
///
- (void)setLanguageWithValue:(NSString * _Nonnull)value SWIFT_DEPRECATED_MSG("", "setLanguage:error:");
/// All the configs should be done <code>BEFORE</code> calling <code>showSurveys()</code>.
/// InBrain will be presented from inBrainDelegate (if subclass of UIViewController) OR from UIApplication’s keyWindow.
- (void)showSurveys SWIFT_DEPRECATED_MSG("", "showSurveysFrom:");
/// All the configs should be done <code>BEFORE</code> calling <code>showSurveys()</code>.
/// InBrain will be presented from inBrainDelegate (if subclass of UIViewController) OR from UIApplication’s keyWindow.
- (void)showNativeSurveyWithId:(NSString * _Nonnull)surveyId SWIFT_DEPRECATED_MSG("", "showNativeSurveyWithId:placementId:from:");
/// All the configs should be done <code>BEFORE</code> calling <code>showSurveys()</code>.
/// \param viewController - ViewController to present InBrain from.
///
- (void)showNativeSurveyWithId:(NSString * _Nonnull)surveyId from:(UIViewController * _Nonnull)viewController SWIFT_DEPRECATED_MSG("", "showNativeSurveyWithId:placementId:from:");
/// Get native surveys for the user. Result will be delivered to <code>NativeSurveyDelegate</code>.
/// Available native surveys will be changed after user complete some.
/// In order to keep you with up-to-date surveys - SDK will provide a fresh portion of Native Surveys after user completed some.
- (void)getNativeSurveys SWIFT_DEPRECATED_MSG("", "getNativeSurveysWithPlacementId:");
/// Get native surveys just once.
/// After survey completed - some Native Surveys may became invalid.
/// Please, re-load native surveys after InBrain WebView dismissed. As alternative -
/// use <code>NativeSurveyDelegate</code> and <code>getNativeSurveys()</code> method.
- (void)getNativeSurveysWithSuccess:(void (^ _Nonnull)(NSArray<InBrainNativeSurvey *> * _Nonnull))success failed:(void (^ _Nonnull)(NSError * _Nonnull))failed SWIFT_DEPRECATED_MSG("", "getNativeSurveys(placementId:success:failed:)");
@end




@class NSDate;

SWIFT_CLASS("_TtC24InBrainSurveys_SDK_Swift19InBrainCurrencySale")
@interface InBrainCurrencySale : NSObject
@property (nonatomic, readonly, copy) NSString * _Nonnull title;
@property (nonatomic, readonly) double multiplier;
@property (nonatomic, readonly, copy) NSDate * _Nonnull start;
@property (nonatomic, readonly, copy) NSDate * _Nonnull end;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


/// Allows your app to handle events from InBrain service
/// *
SWIFT_PROTOCOL("_TtP24InBrainSurveys_SDK_Swift15InBrainDelegate_")
@protocol InBrainDelegate
@optional
/// Called if <code>getRewards()</code>completed successfully
/// \param rewardsArray List of rewards, which weren’t confirmed yet.
///
- (void)didReceiveInBrainRewardsWithRewardsArray:(NSArray<InBrainReward *> * _Nonnull)rewardsArray;
/// Called if <code>getRewards()</code>failed
- (void)didFailToReceiveRewardsWithError:(NSError * _Nonnull)error;
/// Called upon dismissal of inBrainWebView.
/// important:
/// If you are using NativeSurveys - please, ensure the surveys reloaded after some survey(s) completed.
/// \param byWebView <em>true</em> means closed by WebView’s command; <em>false</em> - closed by user;
///
/// \param completedSurvey <em>true</em> means some survey(s) completed (succeded or disqualified).
///
- (void)surveysClosedByWebView:(BOOL)byWebView completedSurvey:(BOOL)completedSurvey;
- (void)surveysClosedFromPage SWIFT_UNAVAILABLE_MSG("'surveysClosedFromPage' has been renamed to 'surveysClosedByWebView:completedSurvey:'");
- (void)surveysClosed SWIFT_UNAVAILABLE_MSG("'surveysClosed' has been renamed to 'surveysClosedByWebView:completedSurvey:'");
@end

enum SurveyProfileMatch : NSInteger;

SWIFT_CLASS("_TtC24InBrainSurveys_SDK_Swift19InBrainNativeSurvey")
@interface InBrainNativeSurvey : NSObject
@property (nonatomic, readonly, copy) NSString * _Nonnull id;
@property (nonatomic, readonly, copy) NSString * _Nullable placementId;
@property (nonatomic, readonly) NSInteger rank;
@property (nonatomic, readonly) NSInteger time;
@property (nonatomic, readonly) double value;
@property (nonatomic, readonly) enum SurveyProfileMatch profileMatch;
@property (nonatomic, readonly) BOOL currencySale;
@property (nonatomic, readonly) double multiplier;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class UIColor;

SWIFT_CLASS("_TtC24InBrainSurveys_SDK_Swift19InBrainNavBarConfig")
@interface InBrainNavBarConfig : NSObject
/// Config to customize Navigation Bar.
/// <ul>
///   <li>
///     Color values should be in sRGB (Device RGB) profile;
///   </li>
///   <li>
///     Pass nil to use default color.
///   </li>
/// </ul>
/// \param backgroundColor Background color of navigation bar
///
/// \param buttonsColor Back/Close buttons color
///
/// \param titleColor Navigation bar title color
///
/// \param isTranslucent Translucent navigation bar. Default value is false
///
/// \param hasShadow Show/hide defualt navigation bar shadow. Default value is false
///
- (nonnull instancetype)initWithBackgroundColor:(UIColor * _Nullable)backgroundColor buttonsColor:(UIColor * _Nullable)buttonsColor titleColor:(UIColor * _Nullable)titleColor isTranslucent:(BOOL)isTranslucent hasShadow:(BOOL)hasShadow OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24InBrainSurveys_SDK_Swift13InBrainReward")
@interface InBrainReward : NSObject
@property (nonatomic, readonly) NSInteger transactionId;
@property (nonatomic, readonly) float amount;
@property (nonatomic, readonly, copy) NSString * _Nonnull currency;
@property (nonatomic, readonly) NSInteger transactionType;
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC24InBrainSurveys_SDK_Swift22InBrainStatusBarConfig")
@interface InBrainStatusBarConfig : NSObject
/// Config to customize Status Bar.
/// \param statusBarStyle UIStatusBarStyle to be used
///
/// \param hideStatusBar Hide status bar if true
///
- (nonnull instancetype)initWithStatusBarStyle:(UIStatusBarStyle)statusBarStyle hideStatusBar:(BOOL)hideStatusBar OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


/// Allows your app to handle NativeSurveys events from InBrain service
/// *
SWIFT_PROTOCOL("_TtP24InBrainSurveys_SDK_Swift20NativeSurveyDelegate_")
@protocol NativeSurveyDelegate
/// Called just after loading of NativeSurveys started.
/// Can be used to show some loading process at the UI
/// Native surveys loading can be triggered in next cases:
/// <ol>
///   <li>
///     Manually, using <code>getNativeSurveys()</code> method;
///   </li>
///   <li>
///     Automatically, after user completed some of Native Surveys, received before.
///   </li>
/// </ol>
- (void)nativeSurveysLoadingStarted SWIFT_UNAVAILABLE_MSG("'nativeSurveysLoadingStarted' has been renamed to 'nativeSurveysLoadingStartedWithPlacementId:'");
- (void)nativeSurveysLoadingStartedWithPlacementId:(NSString * _Nullable)placementId;
/// Provides fresh portion of Native surveys. Update app UI with actual surveys.
/// Native surveys can be loaded in next cases:
/// <ol>
///   <li>
///     Manually, using <code>getNativeSurveys()</code> method;
///   </li>
///   <li>
///     Automatically, after user completed some of Native Surveys, received before.
///   </li>
/// </ol>
/// \param surveys List of available Native Surveys.
///
- (void)nativeSurveysReceived:(NSArray<InBrainNativeSurvey *> * _Nonnull)surveys SWIFT_UNAVAILABLE_MSG("'nativeSurveysReceived' has been renamed to 'nativeSurveysReceived(surveys:placementId:)'");
- (void)nativeSurveysReceived:(NSArray<InBrainNativeSurvey *> * _Nonnull)surveys placementId:(NSString * _Nullable)placementId;
/// Called if loading of Native Surveys failed
/// *
- (void)failedToReceiveNativeSurveysWithError:(NSError * _Nonnull)error SWIFT_UNAVAILABLE_MSG("'failedToReceiveNativeSurveys' has been renamed to 'failedToReceiveNativeSurveysWithError:placementId:'");
- (void)failedToReceiveNativeSurveysWithError:(NSError * _Nonnull)error placementId:(NSString * _Nullable)placementId;
@end

/// Indicates how the survey match user’s profile
typedef SWIFT_ENUM(NSInteger, SurveyProfileMatch, open) {
  SurveyProfileMatchNewSurvey = 0,
  SurveyProfileMatchPoorMatch = 1,
  SurveyProfileMatchFairMatch = 2,
  SurveyProfileMatchGoodMatch = 3,
  SurveyProfileMatchGreatMatch = 4,
  SurveyProfileMatchExcellentMatch = 5,
};



#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
#endif
