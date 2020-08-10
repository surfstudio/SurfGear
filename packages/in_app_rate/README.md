# in_app_rate

Plugin open native dialog for application rate/review.

## iOS

iOS part use [SKStoreReviewController](https://developer.apple.com/documentation/storekit/skstorereviewcontroller).
[Best Practices](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/requesting_app_store_reviews) for a moment to use it.
Note from [documentation](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview).
***
When you call this method while your app is still in development mode, a rating/review request view is always displayed so that you can test the user interface and experience. However, this method has no effect when you call it in an app that you distribute using TestFlight.
***

## Android

Android part use [Google Play In-App Review API](https://developer.android.com/guide/playcore/in-app-review).
[Best Practices](https://developer.android.com/guide/playcore/in-app-review#when-to-request) for a moment to use it.
[Testing](https://developer.android.com/guide/playcore/in-app-review/test), if you set `isTest` to `True` then plugin will use `FakeReviewManager`.
