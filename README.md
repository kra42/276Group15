# 276Group15

//weatherSDK setup guide


sudo gem install cocoapods

pod setup -verbose


// go to project directory

pod init

open -a Xcode Podfile

//in the pod file add the following under ‘Pods for “project”’

pod ‘AerisWeather’

pod 'Firebase'

pod 'FirebaseDatabase'

//after saving pod file, go back to terminal

pod install

//Open .workspace file and you’re done kid
