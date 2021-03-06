
# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and `InBrainSurveys` adheres to [Semantic Versioning](http://semver.org/).


## [1.6.0](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.6.0) - 2021-02-26

### Added
- Landscape mode for SDK and demo app.
---

## [1.5.2](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.5.2) - 2021-01-20

### Fixed
- Return no surveys in case of `timeout` error for `Native Surveys` request.
---

## [1.5.1](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.5.1) - 2021-01-15

### Fixed
- Hide activity indicator after `Profiler` survey loaded.
---

## [1.5.0](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.5.0) - 2021-01-13

### Added
- Custom loading indicator.

### Fixed
- Open redirects and links at new widnow.
---

## [1.4.12](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.12) - 2020-12-11

### Fixed
- Environment variables hotfix.
---

## [1.4.11](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.11) - 2020-12-11

### Added
- Request feedback if survey closed by user.
---

## [1.4.10](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.10) - 2020-12-04

### Changed
- Timeout for API requests increased to 10 seconds.

### Fixed
- Updates from previous releases, which were lost by merge issue.
---

## [1.4.9](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.9) - 2020-12-03

### Changed
- Default styles for Navigation and Status bars.

### Fixed
- Navigation's bar shadow.
---

## [1.4.8](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.8) - 2020-12-02

### Added
- `InBrainStatusBarConfig` alongside with `setStatusBarConfig` for Status bar customization.

### Changed
- `InBrainNavBarConfig` alongside with `setNavigationBarConfig` added for Navigation bar customization instead of the old methods. Old methods are deprecated.

### Fixed
- `Native Survey` reopening after user pressed `Back` at the `Native Survey`.
---

## [1.4.7](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.7) - 2020-12-01

### Changed
- Call API request failed callbacks from `Main` queue;
- Timeout for API requests set to 5 seconds;
- Don't remove "close" button from navigation bar.

### Fixed
- `Native Survey` reopening after user pressed `Back` at the `Native Survey`.
---

## [1.4.6](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.6) - 2020-11-11

### Added
- Get `Native Surveys` with callbacks.
---

## [1.4.5](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.5) - 2020-11-09

### Fixed
- Reload `Native Surveys` if some were completed.
---

## [1.4.4](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.4) - 2020-10-29

### Fixed
- Minor fixes and improvements.
---

## [1.4.3](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.3) - 2020-10-26

### Changed
- Existing `getRewards` method deprecated and new one added.

### Fixed
- Use `IDFV` for API requests in case if `user_id `not set or empty;
- Deprecation marks.
---

## [1.4.2](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.2) - 2020-10-21

### Added
- Keep auth token while valid and use it for the API requests;
- Refresh expired auth token.

### Changed
- Improvements for API error handling.

### Fixed
- Get rewards after `Profiler` survey;
- Portrait orientation for `WKWebView` if app supports landscape-only.
---

## [1.4.1](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.1) - 2020-10-16

### Fixed
- `WKWebView` orientation;
- Demo app minor fixes and improvements.
---

## [1.4.0](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/1.4.0) - 2020-10-13

### Added
- `Native Surveys`;
- Check for available surveys;
- Demo app (swift).

### Changed
- Navigation bar customization methods.

### Fixed
- Portrait orientation for `WKWebView`;
- Minor fixes and improvements.
---

## [1.3.5](https://github.com/inbrainai/inBrainSurveys_SDK/releases/tag/v1.3.5) - 2020-09-25
 
### Added
- Show surveys from desired `UIViewController`.

### Fixed
- Show surveys if `inBrainDelegate` not a UIViewController's subclass;
- Performance and stability imporvements and fixes.

