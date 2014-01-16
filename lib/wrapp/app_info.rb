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
      `/usr/libexec/PlistBuddy -c 'Print :#{property}' '#{plist}'`.strip
    end
  end
end
