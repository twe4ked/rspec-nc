require 'nc'

RSpec.describe Nc do
  let(:formatter) { Nc.new(StringIO.new) }
  let(:current_dir) { File.basename(File.expand_path '.') }
  let(:terminal_notifier_available) { true }

  before do
    allow(TerminalNotifier).to receive(:available?).and_return(terminal_notifier_available)
  end

  context 'with failing examples' do
    let(:notification) do
      instance_double(RSpec::Core::Notifications::SummaryNotification,
        formatted_duration: '0.0001 seconds',
        totals_line: '3 examples, 1 failure, 1 pending',
        failure_count: 1,
      )
    end

    it 'sends a failure summary notification' do
      expect(TerminalNotifier).to receive(:notify).with(
        "Finished in 0.0001 seconds\n3 examples, 1 failure, 1 pending",
        :title => "#{Nc::FAILURE_EMOJI} #{current_dir}: 1 failed example"
      )
      formatter.dump_summary(notification)
    end
  end

  context 'with all examples passing' do
    let(:notification) do
      instance_double(RSpec::Core::Notifications::SummaryNotification,
        formatted_duration: '0.0001 seconds',
        totals_line: '3 examples, 0 failures, 1 pending',
        failure_count: 0,
      )
    end

    it 'sends a success summary notification' do
      expect(TerminalNotifier).to receive(:notify).with(
        "Finished in 0.0001 seconds\n3 examples, 0 failures, 1 pending",
        :title => "#{Nc::SUCCESS_EMOJI} #{current_dir}: Success"
      )
      formatter.dump_summary(notification)
    end
  end

  context 'when terminal notifier is not availiable' do
    let(:terminal_notifier_available) { false }

    it 'does not send a notification' do
      expect(TerminalNotifier).to_not receive(:notify)
      formatter.dump_summary(double.as_null_object)
    end
  end
end
