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
      let(:command_line) { double('command_line', :run => '') }

      before do
        Cocaine::CommandLine.stub(:new).and_return(command_line)
      end

      it 'builds a new command line object' do
        Cocaine::CommandLine.should_receive(:new).
          with('/usr/libexec/PlistBuddy', '-c :cmd :plist').
          and_return(command_line)
        app.get_property('Foo')
      end

      it 'runs the command line with the property' do
        command_line.should_receive(:run).
          with(:cmd => 'Print Foo', :plist => 'Info.plist').
          and_return('')
        app.get_property('Foo')
      end

      it 'strips the output' do
        command_line.stub(:run).and_return("Chunky\n")
        expect(app.get_property('')).to eq('Chunky')
      end
    end
  end
end
