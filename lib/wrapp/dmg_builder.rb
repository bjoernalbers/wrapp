module Wrapp
  class DMGBuilder
    attr_reader :app_path

    class << self
      def run
        new(ARGV.first).create #TODO: Test this!
      end
    end

    def initialize(app_path)
      @app_path = app_path
    end

    def create
      create_dmg
    end

    private

    def create_dmg
      system("hdiutil create '#{dmg_path}' -srcfolder '#{app_path}'")
    end

    def dmg_path
      dmg_filename
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
