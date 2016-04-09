require 'nc_fail'

describe NcFail do
  let(:formatter) { NcFail.new(StringIO.new) }
  let(:notification) do
    instance_double(RSpec::Core::Notifications::SummaryNotification,
      formatted_duration: double,
      totals_line: double,
      failure_count: failure_count,
    )
  end
  let(:terminal_notifier_available) { true }

  before do
    allow(TerminalNotifier).to receive(:available?).and_return(terminal_notifier_available)
  end

  context 'with failing examples' do
    let(:failure_count) { 1 }

    it 'sends a failure summary notification' do
      expect(TerminalNotifier).to receive(:notify)
      formatter.dump_summary(notification)
    end
  end

  context 'with all examples passing' do
    let(:failure_count) { 0 }

    it 'does not send a notification' do
      expect(TerminalNotifier).to_not receive(:notify)
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
