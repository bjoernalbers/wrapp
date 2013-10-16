def create_app
  FileUtils.rm_f(dmg_filename)
  write_file(plist_path, plist_content)
end

def plist_path
  File.join(app_path, 'Contents', 'Info.plist')
end

def plist_content
  %Q{<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>CFBundleName</key>
    <string>#{app_name}</string>
    <key>CFBundleShortVersionString</key>
    <string>#{app_version}</string>
  </dict>
</plist>
}
end

def run_wrapp_command
  cmd = "wrapp '#{app_path}'"
  run_simple(unescape(cmd))
end

def dmg_filename
  'chunky_bacon_1.2.3.dmg'
end

def app_version
  '1.2.3'
end

def app_name
  'Chunky Bacon'
end

def app_path
  "Applications/#{app_name}.app"
end

Given(/^an App$/) do
  create_app
end

When(/^I run wrapp$/) do
  run_wrapp_command
end

Then(/^the App should be wrapped in a DMG$/) do
  check_file_presence([dmg_filename], true) # assert that dmg exists
  # attach dmg
    # assert that dmg contains the app dir (basedir w/o full path)
  # detach dmg
end
