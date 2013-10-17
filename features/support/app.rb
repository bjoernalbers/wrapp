class App
  def initialize(opts = {})
    @opts = opts
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

  def dmg_filename
    'chunky_bacon_1.2.3.dmg'
  end

  def app_version
    '1.2.3'
  end

  def app_name
    'Chunky Bacon'
  end

  def prefix
    @opts[:prefix]
  end

  def app_path
    basedir = "#{app_name}.app"
    (prefix && File.join(prefix, basedir)) || basedir
  end
end
