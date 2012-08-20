require 'nc'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = 'doc'
  config.formatter = 'Nc'
end

describe Nc do
  let(:formatter)   { Nc.new(StringIO.new) }

  it 'returns the summary' do
    TerminalNotifier.should_receive(:notify).with(
      "Finished in 0.0001 seconds\n3 examples, 1 failure, 1 pending",
      :title => "1 failed example"
    )

    formatter.dump_summary(0.0001, 3, 1, 1)
  end

  it 'returns a failing notification' do
    TerminalNotifier.should_receive(:notify).with(
      "Finished in 0.0001 seconds\n1 example, 1 failure",
      :title => "1 failed example"
    )

    formatter.dump_summary(0.0001, 1, 1, 0)
  end

  it 'returns a success notification' do
    TerminalNotifier.should_receive(:notify).with(
      "Finished in 0.0001 seconds\n1 example, 0 failures",
      :title => "Success"
    )

    formatter.dump_summary(0.0001, 1, 0, 0)
  end
end
