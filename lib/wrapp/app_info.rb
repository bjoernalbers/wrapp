module Wrapp
  class AppInfo
    attr_reader :plist

    def initialize(plist)
      @plist = plist
    end

    def full_name
      separator = '_'
      [name.downcase, version].join(separator).gsub(/\s+/, separator)
    end

    def name
      get_property('CFBundleName')
    end

    def version
      get_property('CFBundleShortVersionString')
    end

    def get_property(property)
      command_line = Cocaine::CommandLine.new('/usr/libexec/PlistBuddy',
                                              '-c :cmd :plist')
      command_line.run(:cmd => "Print #{property}", :plist => plist).strip
    end
  end
end
