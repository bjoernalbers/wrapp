require 'spec_helper'

module Wrapp
  describe DMGBuilder do
    subject { DMGBuilder.new('Chunky Bacon.app') }
    let(:app) { double('app') }

    before do
      allow(app).to receive(:name) { 'Chunky Bacon' }
      allow_any_instance_of(DMGBuilder).to receive(:system)
    end

    describe '#create' do
      it 'creates dmg with hdiutil' do
        allow(subject).to receive(:dmg_filename) { 'bacon.dmg' }
        allow(subject).to receive(:volume_name) { 'Chunky' }
        allow(subject).to receive(:system)
        subject.create
        expect(subject).to have_received(:system).with(
          "hdiutil create -srcfolder 'Chunky Bacon.app' -fs 'HFS+' -volname 'Chunky' 'bacon.dmg'")
      end
    end

    describe '#app_path' do
      it 'returns the app path' do
        expect(subject.app_path).to eq('Chunky Bacon.app')
      end
    end

    describe '#dmg_filename' do
      it 'includes the full app name' do
        allow(app).to receive(:full_name) { 'chunky_bacon_0.4.2' }
        allow(subject).to receive(:app) { app }
        expect(subject.send(:dmg_filename)).to eq('chunky_bacon_0.4.2.dmg')
      end
    end

    describe '#volume_name' do
      context 'with option :volume_name' do
        subject { DMGBuilder.new('...', volume_name: 'Hi') }

        it 'returns volume name from option' do
          expect(subject.volume_name).to eq 'Hi'
        end
      end

      context 'without option :volume_name' do
        subject { DMGBuilder.new('...') }
        let(:app) { double('app') }

        before do
          allow(app).to receive(:name) { 'Hello' }
          allow(subject).to receive(:app) { app }
        end

        it 'returns application name' do
          expect(subject.volume_name).to eq 'Hello'
        end
      end
    end

    describe '#app' do
      it 'creates a cached app_info instance' do
        allow(AppInfo).to receive(:new).with('Chunky Bacon.app') { app }
        expect(subject.send(:app)).to eq(app)
      end
    end
  end
end
