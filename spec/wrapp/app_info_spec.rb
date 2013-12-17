require 'spec_helper'

module Wrapp
  describe AppInfo do
    let(:app) { AppInfo.new('Info.plist') }

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

    describe '#properties' do
      it 'returns the app properties as hash' do
        Plist4r.should_receive(:open).with('Info.plist').
          and_return(:plist_as_hash)
        expect(app.send(:properties)).to eq(:plist_as_hash)
      end
    end

    describe '#get_property' do
      context 'with existing property' do
        it 'returns the striped property' do
          app.stub(:properties).and_return({})
          expect { 
            app.get_property('Chunky')
          }.to raise_error(/no property found: chunky/i)
        end
      end

      context 'with missing property' do
        it 'raises an error' do
          app.stub(:properties).and_return({ 'Chunky' => ' Bacon ' })
          expect(app.get_property('Chunky')).to eq('Bacon')
        end
      end
    end
  end
end
