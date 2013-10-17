require 'spec_helper'

module Wrapp
  describe DMGBuilder do
    let(:dmg) { DMGBuilder.new('Chunky Bacon.app') }
    let(:app) { double('app') }

    before do
      DMGBuilder.any_instance.stub(:system)
    end

    describe '#create' do
      it 'creates the dmg by hdiutil' do
        dmg.should_receive(:source_path).and_return('Chunky.app')
        dmg.should_receive(:dmg_filename).and_return('bacon.dmg')
        dmg.should_receive(:system).
          with("hdiutil create 'bacon.dmg' -srcfolder 'Chunky.app'")
        dmg.create
      end
    end

    describe '#app_path' do
      it 'returns the app path' do
        expect(dmg.app_path).to eq('Chunky Bacon.app')
      end
    end

    describe '#source_path' do
      before do
        dmg.should_receive(:app_path).and_return('Chunky/Bacon.app')
      end

      it 'returns the path of the app dir' do
        expect(dmg.send(:source_path)).to eq('Chunky/Bacon.app')
      end

      context 'with :include_parent_dir => true' do
        let(:dmg) { DMGBuilder.new('...', :include_parent_dir => true) }

        it 'returns the path of the app parent dir' do
          expect(dmg.send(:source_path)).to eq('Chunky')
        end
      end
    end

    describe '#dmg_filename' do
      it 'includes the full app name' do
        app.should_receive(:full_name).and_return('chunky_bacon_0.4.2')
        dmg.stub(:app).and_return(app)
        expect(dmg.send(:dmg_filename)).to eq('chunky_bacon_0.4.2.dmg')
      end
    end

    describe '#app' do
      it 'creates a cached app_info instance' do
        dmg.should_receive(:plist).and_return('Info.plist')
        AppInfo.should_receive(:new).once.with('Info.plist').and_return(app)
        expect(dmg.send(:app)).to eq(app)
      end
    end

    describe '#plist' do
      it 'returns the app info plist path' do
        expect(dmg.send(:plist)).to eq('Chunky Bacon.app/Contents/Info.plist')
      end
    end
  end
end
