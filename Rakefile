
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
#sh "rm -rf ~/Library/Developer/Xcode/DerivedData/* || true"
#sh "rm -rf ~/Library/Developer/CoreSimulator/* || true"
#sh "rm -rf slather-report || true"
#sh "xcodebuild clean build -workspace Example/Glasgow.xcworkspace -scheme Glasgow-Example -destination 'platform=iOS Simulator,name=iPhone X' VALID_ARCHS=x86_64 test | xcpretty"
sh "bundle exec slather > /dev/null"
sh "open slather-report/index.html > /dev/null"
end

desc "Generates Jazzy Report"
task :docs do
sh "git submodule init || true"
sh "git submodule update || true"
sh "cd docs; git checkout master; git pull; cd .."
sh "rm -rf docs/latest || true"
@version = `cat Glasgow.podspec | grep 's.version' | head -n1 | grep -o '[0-9][0-9.]*[0-9]'`.delete!("\n")
sh "rm -rf docs/#{@version} || true"
sh "jazzy --podspec Glasgow.podspec --swift-version 3.1 --author \"Inácio Ferrarini\" --github_url https://github.com/inacioferrarini/glasgow --download-badge --output docs/latest"
sh "cp -rf docs/latest docs/#{@version}"
sh "cd docs; git add .; git commit -m \"Auto generated documentation for version #{@version}\"; git push; cd .."
end
