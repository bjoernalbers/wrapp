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
      it 'reads the properties via PlistBuddy' do
        app.should_receive(:`).
          with("/usr/libexec/PlistBuddy -c 'Print :Foo' 'Info.plist'").
          and_return('')
        app.get_property('Foo')
      end

      it 'strips the output' do
        app.stub(:`).and_return("Chunky\n")
        expect(app.get_property('')).to eq('Chunky')
      end

      it 'raises on missing properties' do
        pending 'how do i test this?'
      end
    end
  end
end
