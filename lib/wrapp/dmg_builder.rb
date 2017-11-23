module Wrapp
  class DMGBuilder
    DEFAULT_FILESYSTEM = 'HFS+'

    attr_reader :app_path

    def initialize(app_path, opts = {})
      @app_path = app_path
      @opts = opts
    end

    def create
      cmd = %w(hdiutil create)
      cmd << "-srcfolder '#{app_path}'"
      cmd << "-fs '#{filesystem}'"
      cmd << "-volname '#{volume_name}'"
      cmd << "'#{dmg_filename}'"
      system(cmd.join(' '))
    end

    def filesystem
      @opts.fetch(:filesystem) { DEFAULT_FILESYSTEM }
    end

    def volume_name
      @opts.fetch(:volume_name) { app.name }
    end

    private

    #def source_path
      #@opts[:include_parent_dir] ? File.dirname(app_path) : app_path
    #end

    def dmg_filename
      "#{app.full_name}.dmg"
    end

    def app
      @app_info ||= AppInfo.new(app_path)
    end
  end
end
