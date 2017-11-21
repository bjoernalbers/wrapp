require 'spec_helper'

module Wrapp
  describe CLI do
    let(:cli) { CLI.new }
    let(:app_path) { '/Applications/Chunky Bacon.app' }

    it 'include usage instructions in the banner' do
      expect(CLI.banner).to match(/^usage: \w+ \[options\] \w+$/i)
    end

    describe '.run' do
      it 'runs an instance with ARGV' do
        cli.should_receive(:run).with(ARGV)
        CLI.stub(:new).and_return(cli)
        CLI.run
      end

      context 'without arguments' do
        let(:argv) { [] }

        before do
          cli.stub(:warn)
          cli.stub(:puts)
          cli.stub(:exit)
        end

        it 'exits non-zero' do
          cli.should_receive(:exit).with(2)
          cli.run(argv)
        end

        it 'displays usage on stdout' do
          cli.should_receive(:opt_parser).and_return('usage')
          cli.should_receive(:puts).with('usage')
          cli.run(argv)
        end

        it 'displays what is missing on stderr' do
          cli.should_receive(:warn).with('ERROR: App path is missing!')
          cli.run(argv)
        end
      end
    end

    describe '#run' do
      let(:argv) { [app_path] }

      it 'wraps the app' do
        cli.should_receive(:wrapp).with(app_path, {})
        cli.run(argv)
      end

      %w(--include-parent-dir -i).each do |opt|
        context "with #{opt}" do
          let(:argv) { [app_path, opt] }

          it 'wraps the app including the parent directory' do
            cli.should_receive(:wrapp).
              with(app_path, :include_parent_dir => true)
            cli.run(argv)
          end
        end
      end

      %w(--filesystem -fs).each do |opt|
        context "with #{opt}" do
          let(:argv) { [app_path, opt] }

          it 'specifies the filesystem type' do
            cli.should_receive(:wrapp)
              .with(app_path, :filesystem => 'HFS+')
            cli.run(argv)
          end
        end
      end

      %w(--volume-name -n).each do |opt|
        context "with #{opt}" do
          let(:argv) { [app_path, opt] }

          if 'specifies the volume name' do
            cli.should_receive(:wrapp)
              .with(app_path, :volume_name => '')
            cli.run(argv)
          end
        end
      end
    end

    describe '#wrapp' do
      it 'creates the dmg via dmg builder' do
        opts = %(some options and arguments)
        dmg = double('dmg_builder')
        dmg.should_receive(:create)
        DMGBuilder.should_receive(:new).with(*opts).and_return(dmg)
        cli.wrapp(*opts)
      end
    end
  end
end
