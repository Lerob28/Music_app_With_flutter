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


4- add single page for now playing song and redirect user to it
5- make song playing when redirecting
6- implement the play pause song functionnality
7- implement the stop song when navigating back to the songs list
8- implement the modify slider player method
9- show the image of song in list song view with given widget of on_audio_player package
10- making song playing in background
    # adding permission to android Manifest file