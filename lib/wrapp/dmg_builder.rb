module Wrapp
  class DMGBuilder
    attr_reader :app_path

    def initialize(app_path, opts = {})
      @app_path = app_path
      @opts = opts
    end

    def create
      system("hdiutil create '#{dmg_filename}' -srcfolder '#{source_path}'")
    end

    private

    def source_path
      @opts[:include_parent_dir] ? File.dirname(app_path) : app_path
    end

    def dmg_filename
      "#{app.full_name}.dmg"
    end

    def app
      @app_info ||= AppInfo.new(plist)
    end

    def plist
      File.join(app_path, 'Contents', 'Info.plist')
    end
  end
end
