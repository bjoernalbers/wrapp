module Wrapp
  class DMGBuilder
    BIG_SOURCE_FOLDER_SIZE = 100

    attr_reader :app_path

    def initialize(app_path, opts = {})
      @app_path = app_path
      @opts = opts
    end

    def create
      cmd = %w(hdiutil create)
      cmd << "-srcfolder '#{source_path}'"
      # NOTE: There is a known bug in hdiutil that causes the image creation
      # to fail, see: https://discussions.apple.com/thread/5667409
      # Therefore we have to explicitely set the dmg size for bigger sources.
      cmd << "-megabytes #{dmg_size}" if big_source_folder?
      cmd << "-volname '#{vol_name}'"
      cmd << "-fs '#{@opts[:filesystem]}'"
      cmd << "'#{dmg_filename}'"

      system(cmd.join(' '))
    end

    private

    def source_path
      @opts[:include_parent_dir] ? File.dirname(app_path) : app_path
    end

    # @returns [Boolean] true if source folder is bigger or equal then 100MB.
    def big_source_folder?
      folder_size >= BIG_SOURCE_FOLDER_SIZE
    end

    # @returns [Integer] Size of dmg in megabytes.
    def dmg_size
      (folder_size * 1.1).to_i # Source folder + 10% buffer.
    end

    # @returns [Integer] Size of source folder in megabytes.
    def folder_size
      `du -ms '#{source_path}'`[/^(\d+)\s+/,1].to_i
    end

    def dmg_filename
      "#{app.full_name}.dmg"
    end

    def vol_name
      @opts[:volume_name] ? @opts[:volume_name] : app.name
    end

    def app
      @app_info ||= AppInfo.new(plist)
    end

    def plist
      File.join(app_path, 'Contents', 'Info.plist')
    end
  end
end
