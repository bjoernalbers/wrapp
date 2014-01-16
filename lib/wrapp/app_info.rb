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
      output = `/usr/libexec/PlistBuddy -c 'Print :#{property}' '#{plist}'`
      raise "Error reading #{property} from #{plist}" unless $?.success?
      output.strip
    end
  end
end
