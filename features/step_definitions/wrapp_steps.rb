# Helpers

def create_app(*opts)
  app = App.new(*opts)
  FileUtils.rm_f(app.dmg_filename)
  write_file(app.plist_path, app.plist_content)
  app
end


def attach_dmg
  assert_dmg_exists
  create_directory(volumes_dir)
  cmd = "hdiutil attach '#{@app.dmg_filename}' -nobrowse -mountroot '#{volumes_dir}'"
  run_simple(cmd, true)
end

def detach_dmg
  cd('.') do
    Dir.glob("#{volumes_dir}/*") do |dir|
      system("hdiutil detach '#{dir}' -force >/dev/null")
    end
  end
end

def assert_dmg_exists
  expect(@app.dmg_filename).to be_an_existing_file
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
  run_simple(sanitize_text(cmd))
end

Then(/^the App should be wrapped$/) do
  attach_dmg
  attached_app_path = File.join(volumes_dir, @app.app_name)
  expect(attached_app_path).to be_an_existing_directory
end

Then(/^I should see usage instructions$/) do
  expected = "Usage: wrapp [options] APP_PATH"
  expect(last_command_stopped).to have_output an_output_string_including(expected)
end
