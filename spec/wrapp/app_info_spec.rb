require 'spec_helper'

module Wrapp
  describe AppInfo do
    let(:app) { AppInfo.new('Info.plist') }

    before do
      AppInfo.any_instance.stub(:`)
    end

    describe '#full_name' do
      it 'includes the downcased name and version without spaces' do
        app.stub(:name).and_return("Chunky\t Bacon")
        app.stub(:version).and_return('1.2.3')
        expect(app.full_name).to eq('chunky_bacon_1.2.3')
      end
    end

    describe '#name' do
      it 'returns the app name' do
        app.should_receive(:get_property).
          with('CFBundleName').
          and_return('Chunky Bacon')
        expect(app.name).to eq('Chunky Bacon')
      end
    end

    describe '#version' do
      it 'returns the app version' do
        app.should_receive(:get_property).
          with('CFBundleShortVersionString').
          and_return('0.4.2')
        expect(app.version).to eq('0.4.2')
      end
    end

    describe '#get_property' do
      it 'retrieves the property by PlistBuddy' do
        app.should_receive(:`).
          with("/usr/libexec/PlistBuddy -c 'Print :foo' 'Info.plist'").
          and_return('')
        app.get_property('foo')
      end

      it 'strips the output' do
        app.stub(:`).and_return("Chunky\n")
        expect(app.get_property(nil)).to eq('Chunky')
      end

      it 'raises when plistbuddy exists non-zero' do
        app.stub(:`).and_return { system('false'); '' }
        expect {
          app.get_property('Foo')
        }.to raise_error /error reading foo from info.plist/i
      end
    end
  end
end
