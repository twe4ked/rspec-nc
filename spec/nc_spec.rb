require 'nc'

describe Nc do
  let(:formatter)   { Nc.new(StringIO.new) }
  let(:current_dir) { File.basename(File.expand_path '.') }

  # emoji
  let(:success) { "\u2705" }
  let(:failure) { "\u26D4" }

  it 'returns the summary' do
    TerminalNotifier.should_receive(:notify).with(
      "Finished in 0.0001 seconds\n3 examples, 1 failure, 1 pending",
      :title => "#{failure} #{current_dir}: 1 failed example"
    )

    formatter.dump_summary(0.0001, 3, 1, 1)
  end

  it 'returns a failing notification' do
    TerminalNotifier.should_receive(:notify).with(
      "Finished in 0.0001 seconds\n1 example, 1 failure",
      :title => "#{failure} #{current_dir}: 1 failed example"
    )

    formatter.dump_summary(0.0001, 1, 1, 0)
  end

  it 'returns a success notification' do
    TerminalNotifier.should_receive(:notify).with(
      "Finished in 0.0001 seconds\n1 example, 0 failures",
      :title => "#{success} #{current_dir}: Success"
    )

    formatter.dump_summary(0.0001, 1, 0, 0)
  end
end
