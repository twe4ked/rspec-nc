require 'nc_first_fail'

describe NcFirstFail do
  let(:formatter) { NcFirstFail.new(StringIO.new) }
  let(:current_dir) { File.basename(File.expand_path '.') }
  let(:example) { double 'example' }
  let(:example2) { double 'example2' }

  let(:failure) { "\u26D4" }
  let(:success) { "\u2705" }
  let(:exception) { 'exception' }
  let(:description) { 'description' }

  context 'with RSpec 2' do
    before do
      allow(formatter.class).to receive(:rspec_3?).and_return(false)
    end

    it 'notifies the first failure only' do
      allow(example).to receive(:metadata).and_return({:full_description => description})
      allow(example).to receive(:exception).and_return(exception)

      expect(TerminalNotifier).to receive(:notify).with("#{description}\n#{exception}",
        :title => "#{failure} #{current_dir}: Failure"
      ).once

      formatter.example_failed(example)
      formatter.example_failed(example2)
    end

    it "doesn't notify in the end if there has been any failures" do
      expect(TerminalNotifier).to_not receive(:notify)

      formatter.dump_summary(0.0001, 2, 1, 0)
    end

    it 'notifies in the end if there is no failures' do
      expect(TerminalNotifier).to receive(:notify).with(
        "Finished in 0.0001 seconds\n2 examples, 0 failures",
        :title => "#{success} #{current_dir}: Success"
      )

      formatter.dump_summary(0.0001, 2, 0, 0)
    end
  end

  context 'with RSpec 3' do
    let(:notification) do
      Struct.new(:duration, :example_count, :failure_count, :pending_count).new(0.0001, 3, 1, 1)
    end
    let(:success_notification) do
      Struct.new(:duration, :example_count, :failure_count, :pending_count).new(0.0001, 2, 0, 0)
    end

    before do
      allow(formatter.class).to receive(:rspec_3?).and_return(true)
    end

    it 'notifies the first failure only' do
      allow(example).to receive(:metadata).and_return({:full_description => description})
      allow(example).to receive(:exception).and_return(exception)

      expect(TerminalNotifier).to receive(:notify).with("#{description}\n#{exception}",
        :title => "#{failure} #{current_dir}: Failure"
      ).once

      formatter.example_failed(double(example: example))
      formatter.example_failed(double(example: example2))
    end

    it "doesn't notify in the end if there has been any failures" do
      expect(TerminalNotifier).to_not receive(:notify)

      formatter.dump_summary(notification)
    end

    it 'notifies in the end if there is no failures' do
      expect(TerminalNotifier).to receive(:notify).with(
        "Finished in 0.0001 seconds\n2 examples, 0 failures",
        :title => "#{success} #{current_dir}: Success"
      )

      formatter.dump_summary(success_notification)
    end
  end
end
