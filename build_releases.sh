mkdir release-builds

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

artifact_name=$(cd android && ./gradlew printFullArtifactName | grep 'netzpolitik')

## build android apk and move it to release-builds folder
flutter build apk
mv build/app/outputs/apk/release/*.apk release-builds

## build ios Runners.app, convert it to ipa and move it to release-builds folder
flutter build ios

mkdir -p release-builds/Payload
mv ./build/ios/iphoneos/Runner.app release-builds/Payload
zip -r -y release-builds/Payload.zip release-builds/Payload/Runner.app
mv release-builds/Payload.zip "release-builds/${artifact_name}.ipa"

rm -Rf release-builds/Payload
