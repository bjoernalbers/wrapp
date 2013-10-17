def create_app
  app = App.new
  FileUtils.rm_f(app.dmg_filename)
  write_file(app.plist_path, app.plist_content)
  app
end

def assert_dmg_exists
  check_file_presence([@app.dmg_filename], true)
end

def assert_dmg_contains_app
  attach_dmg

  d = 'Volumes/Chunky Bacon'
  check_directory_presence([d], true)
end

def wrap
  cmd = "wrapp '#{@app.app_path}'"
  run_simple(unescape(cmd))
end

def volumes_dir
  'Volumes' # We don't want to attach to '/Volumes' in our tests.
end

def attach_dmg
  create_dir(volumes_dir)
  cmd = "hdiutil attach '#{@app.dmg_filename}' -nobrowse -mountroot '#{volumes_dir}'"
  run_simple(cmd, true)
end

def detach_dmg
  in_current_dir do
    Dir.glob("#{volumes_dir}/*") do |dir|
      system("hdiutil detach '#{dir}' -force >/dev/null")
    end
  end
end

After do
  detach_dmg
end

Given(/^an App$/) do
  @app = create_app
end

When(/^I wrap the App$/) do
  wrap
end

Then(/^the App should be wrapped in a DMG$/) do
  assert_dmg_exists
  assert_dmg_contains_app
end

Given(/^an App in a sub\-directory$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I wrap the App with the parent directory$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^the App should be wrapped with the parent directory$/) do
  pending # express the regexp above with the code you wish you had
end
