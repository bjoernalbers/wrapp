module Wrapp
  class CLI
    include Mixlib::CLI

    banner "Usage: #{File.basename($0)} [options] APP_PATH"

    option :include_parent_dir,
      :long => '--include-parent-dir',
      :short => '-i',
      :description => "Include the App's parent directory in the DMG with all(!!!) content.",
      :boolean => true

    option :filesystem,
      :long => '--filesystem FILESYSTEM',
      :short => '-f FILESYSTEM',
      :description => "Causes a filesystem of the specified type to be written to the image.",
      :default => 'HFS+'

    option :volume_name,
      :long => '--volume-name NAME',
      :short => '-n NAME',
      :description => "Volume name of the newly created filesystem."

    class << self
      def run
        new.run(ARGV)
      end
    end

    def run(argv)
      app_path = parse_options(argv).first
      if app_path
        wrapp(app_path, config)
      else
        warn 'ERROR: App path is missing!'
        puts opt_parser
        exit 2 
      end
    end

    def wrapp(*opts)
      DMGBuilder.new(*opts).create
    end
  end
end
