require 'nc_fail'

describe NcFail do
  let(:formatter) { NcFail.new(StringIO.new) }

  it 'returns a failing notification' do
    expect(TerminalNotifier).to receive(:notify)

    formatter.instance_variable_set('@failed_examples', [1])
    formatter.say('title', 'body')
  end

  it 'does not return a success notification when tests are passing' do
    expect(TerminalNotifier).to_not receive(:notify)

    formatter.say('title', 'body')
  end
end
