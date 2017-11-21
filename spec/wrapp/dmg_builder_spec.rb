require 'spec_helper'

module Wrapp
  describe DMGBuilder do
    let(:dmg) { DMGBuilder.new('Chunky Bacon.app') }
    let(:app) { double('app') }

    before do
      DMGBuilder.any_instance.stub(:system)
    end

    describe '#create' do
      before do
        dmg.stub(:source_path).and_return('Chunky.app')
        dmg.stub(:dmg_filename).and_return('bacon.dmg')
      end

      context 'with big source folder' do
        it 'creates a dmg with predefined size' do
          dmg.stub(:big_source_folder?).and_return(true)
          dmg.stub(:dmg_size).and_return(123)
          dmg.should_receive(:system).
            with("hdiutil create -srcfolder 'Chunky.app' -megabytes 123 'bacon.dmg'")
          dmg.create
        end
      end

      context 'with small source folder' do
        it 'creates a dmg with automatic size' do
          dmg.stub(:big_source_folder?).and_return(false)
          dmg.should_receive(:system).
            with("hdiutil create -srcfolder 'Chunky.app' 'bacon.dmg'")
          dmg.create
        end
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

    describe '#big_source_folder?' do
      it 'is true with source folder >= 100MB' do
        dmg.stub(:folder_size).and_return(100)
        expect(dmg.send(:big_source_folder?)).to be true
      end

      it 'is false with source folder < 100MB' do
        dmg.stub(:folder_size).and_return(99)
        expect(dmg.send(:big_source_folder?)).to be false
      end
    end

    describe '#dmg_size' do
      it 'returns the folder size + 10% buffer' do
        dmg.stub(:folder_size).and_return(100)
        expect(dmg.send(:dmg_size)).to eq(110)
      end
    end

    describe '#folder_size' do
      it 'gets the folder size by du command' do
        dmg.stub(:source_path).and_return('/chunky/bacon')
        dmg.should_receive(:`).with("du -ms '/chunky/bacon'").and_return('')
        dmg.send(:folder_size)
      end

      it 'returns the folder size plus 10%' do
        dmg.stub(:source_path).and_return('/chunky/bacon')
        dmg.stub(:`).and_return('100     /chunky/bacon')
        expect(dmg.send(:folder_size)).to eq(100)
      end
    end

    describe '#dmg_filename' do
      it 'includes the full app name' do
        app.should_receive(:full_name).and_return('chunky_bacon_0.4.2')
        dmg.stub(:app).and_return(app)
        expect(dmg.send(:dmg_filename)).to eq('chunky_bacon_0.4.2.dmg')
      end
    end

    describe '#vol_name' do
      if 'returns the volume name' do
          app.should_receive(:name).and_return('chunky_bacon')
          dmg.stub(:app).and_return(app)
          expect(dmg.send(:vol_name)).to eq('chunky_bacon')
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
