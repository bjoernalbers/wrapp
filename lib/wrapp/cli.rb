module Wrapp
  class CLI
    include Mixlib::CLI

    option :include_parent_dir,
      :long => '--include-parent-dir'

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
