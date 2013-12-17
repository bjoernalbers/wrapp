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
      raise "No property found: #{property}" unless
        properties.has_key?(property)
      properties[property].strip
    end

    private

    def properties
      Plist4r.open plist
    end
  end
end
