# Stripe
-keep class com.stripe.android.** { *; }
-keep interface com.stripe.android.** { *; }

# React Native Stripe SDK (used internally)
-keep class com.reactnativestripesdk.** { *; }

# Push Provisioning (Google Pay)
-keep class com.stripe.android.pushProvisioning.** { *; }

-dontwarn com.stripe.android.**
-dontwarn com.reactnativestripesdk.**
