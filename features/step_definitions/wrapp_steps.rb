# Helpers

def create_app(*opts)
  app = App.new(*opts)
  FileUtils.rm_f(app.dmg_filename)
  write_file(app.plist_path, app.plist_content)
  app
end


def attach_dmg
  assert_dmg_exists
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

def assert_dmg_exists
  check_file_presence([@app.dmg_filename], true)
end

def volumes_dir
  'Volumes' # We don't want to attach to '/Volumes' in our tests.
end


# Hooks

After do
  detach_dmg
end


# Step definitions

Given(/^an App$/) do
  @app = create_app
end

Given(/^an App in a directory$/) do
  @app = create_app(:prefix => 'Stuff')
end

When(/^I wrap the App$/) do
  cmd = "wrapp '#{@app.app_path}'"
  run_simple(unescape(cmd))
end

When(/^I wrap the App including the parent directory$/) do
  cmd = "wrapp --include-parent-dir '#{@app.app_path}'"
  run_simple(unescape(cmd))
end

When(/^I wrap the App including \/Applications symlink$/) do
  cmd = "wrapp --add-applications-link '#{@app.app_path}'"
  run_simple(unescape(cmd))
end

Then(/^the App should be wrapped$/) do
  attach_dmg
  attached_app_path = File.join(volumes_dir, @app.app_name)
  check_directory_presence([attached_app_path], true)
end

Then(/^the App should be wrapped including the parent directory$/) do
  attach_dmg
  attached_app_path = File.join(volumes_dir, @app.prefix)
  check_directory_presence([attached_app_path], true)
end

Then(/^the app should be wrapped including the \/Applications symlink$/) do
  attach_dmg
  attached_app_path = File.join(volumes_dir, @app.app_name)
  check_directory_presence([File.join(attached_app_path, 'Applications')], true)
end

Then(/^I should see usage instructions$/) do
  expected = "Usage: wrapp [options] APP_PATH"
  assert_partial_output(expected, all_output)
end
