# Uncomment the next line to define a global platform for your project

def shared_pods
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
end

target 'tryout (iOS)' do
  platform :ios, '14.0'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'FirebaseUI'
  shared_pods
end

target 'tryout (macOS)' do
  platform :macos, '10.15'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  shared_pods
end
