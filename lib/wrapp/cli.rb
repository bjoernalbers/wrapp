module Wrapp
  class CLI
    include Mixlib::CLI

    banner "Usage: #{File.basename($0)} [options] APP_PATH"

    option :include_parent_dir,
      :long => '--include-parent-dir',
      :short => '-i',
      :description => "Include the App's parent directory in the DMG with all(!!!) content.",
      :boolean => true

    class << self
      def run
        new.run(ARGV)
      end
    end

    def run(argv)
      app_path = parse_options(argv).first
      wrapp(app_path, config)
    end

    def wrapp(*opts)
      DMGBuilder.new(*opts).create
    end
  end
end
