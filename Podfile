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

  target 'Tests iOS' do
    inherit! :search_paths
    pod 'Firebase'
  end
end

target 'tryout (macOS)' do
  platform :macos, '11.0'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  shared_pods

  target 'Tests macOS' do
    inherit! :search_paths
    pod 'Firebase'
  end
end
