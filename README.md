# Music_app_With_flutter
this is my project where i'm creating music app using flutter ....

# Step to build the app
1 - Create the basic screen to display all the songs.

2 - add and manage package for fetching song on devices and manage permission access.
          remember to add this on android Manifest
              <!-- Android 12 or below  -->
              <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
              <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
              <!-- Android 13 or greater  -->
              <uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
              <uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>
              <uses-permission android:name="android.permission.READ_MEDIA_AUDIO"/>

3 - trying to play the music fetching from device with just_audio package
        ## getting error and try to solve it ( multidexsupport error on android app)
