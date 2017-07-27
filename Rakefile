
desc "Executes pod install and fix files messed up by Cocoapods."
task :install do
sh "cd Example;bundle exec pod install;cd .. || true"
end

desc "Executes pod update and fix files messed up by Cocoapods."
task :update do
sh "cd Example;bundle exec pod update;cd .. || true"
end

desc "Generates Slather Code Coverage Report."
task :slather do
sh "rm -rf ~/Library/Developer/Xcode/DerivedData/* || true"
sh "rm -rf ~/Library/Developer/CoreSimulator/* || true"
sh "rm -rf slather-report || true"
sh "xcodebuild clean build -workspace Example/Glasgow.xcworkspace -scheme Glasgow-Example -destination 'platform=iOS Simulator,name=iPhone 6' VALID_ARCHS=x86_64 test | xcpretty"
sh "bundle exec slather > /dev/null"
sh "open slather-report/index.html > /dev/null"
end

desc "Generates Jazzy Report"
task :jazzy do
sh "jazzy --podspec Glasgow.podspec --swift-version 3.1"
end

desc "Generates Code Style Report."
task :oclint do
sh "echo oclint ... "
end
