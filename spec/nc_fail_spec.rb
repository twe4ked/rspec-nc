require 'nc_fail'

describe NcFail do
  let(:formatter) { NcFail.new(StringIO.new) }
  let(:failure_count) { 1 }
  let(:notification) do
    instance_double(RSpec::Core::Notifications::SummaryNotification,
      formatted_duration: double,
      totals_line: double,
      failure_count: failure_count,
    )
  end

  it 'returns a failing notification' do
    expect(TerminalNotifier).to receive(:notify)
    formatter.dump_summary(notification)
  end

  context 'when all tests are passing' do
    let(:failure_count) { 0 }

    it 'does not return a notification' do
      expect(TerminalNotifier).to_not receive(:notify)
      formatter.dump_summary(notification)
    end
  end
end
