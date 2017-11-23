require 'spec_helper'

module Wrapp
  describe AppInfo do
    let(:path) { '/Applications/Chunky Bacon.app' }
    subject { AppInfo.new(path) }

    before do
      allow(subject).to receive(:`) { '' }
    end

    describe '#full_name' do
      it 'includes the downcased name and version without spaces' do
        allow(subject).to receive(:name) { "Chunky\t Bacon" }
        allow(subject).to receive(:version) { '1.2.3' }
        expect(subject.full_name).to eq('chunky_bacon_1.2.3')
      end
    end

    describe '#name' do
      it 'returns the app name' do
        allow(subject).to receive(:get_property) { 'Chunky Bacon' }
        expect(subject.name).to eq('Chunky Bacon')
        expect(subject).to have_received(:get_property).with('CFBundleName')
      end
    end

    describe '#version' do
      it 'returns the app version' do
        allow(subject).to receive(:get_property) { '0.4.2' }
        expect(subject.version).to eq('0.4.2')
        expect(subject).to have_received(:get_property).
          with('CFBundleShortVersionString')
      end
    end

    describe '#get_property' do
      it 'retrieves the property by PlistBuddy' do
        allow(subject).to receive(:`) { '' }
        subject.get_property('foo')
        expect(subject).to have_received(:`).
          with("/usr/libexec/PlistBuddy -c 'Print :foo' '/Applications/Chunky Bacon.app/Contents/Info.plist'")
      end

      it 'strips the output' do
        allow(subject).to receive(:`) { "Chunky\n" }
        expect(subject.get_property(nil)).to eq('Chunky')
      end

      it 'raises when plistbuddy exists non-zero' do
        allow(subject).to receive(:`) { system('false'); '' }
        expect {
          subject.get_property('Foo')
        }.to raise_error /error reading foo/i
      end
    end

    describe '#plist' do
      it 'returns the app info plist path' do
        expect(subject.send(:plist)).to eq('/Applications/Chunky Bacon.app/Contents/Info.plist')
      end
    end
  end
end
