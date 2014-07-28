require 'nc'

describe Nc do
  let(:formatter)   { Nc.new(StringIO.new) }
  let(:current_dir) { File.basename(File.expand_path '.') }

  # emoji
  let(:success) { "\u2705" }
  let(:failure) { "\u26D4" }

  it 'returns the summary' do
    expect(TerminalNotifier).to receive(:notify).with(
      "Finished in 0.0001 seconds\n3 examples, 1 failure, 1 pending",
      :title => "#{failure} #{current_dir}: 1 failed example"
    )

    call_dump_summary(formatter, 0.0001, 3, 1, 1)
  end

  it 'returns a failing notification' do
    expect(TerminalNotifier).to receive(:notify).with(
      "Finished in 0.0001 seconds\n1 example, 1 failure",
      :title => "#{failure} #{current_dir}: 1 failed example"
    )

    call_dump_summary(formatter, 0.0001, 1, 1, 0)
  end

  it 'returns a success notification' do
    expect(TerminalNotifier).to receive(:notify).with(
      "Finished in 0.0001 seconds\n1 example, 0 failures",
      :title => "#{success} #{current_dir}: Success"
    )

    call_dump_summary(formatter, 0.0001, 1, 0, 0)
  end

  private

  def call_dump_summary(formatter, duration, example_count, failure_count, pending_count)
    if RSpec::Core::Version::STRING =~ /^3/
      summary = Struct.new(:duration, :example_count, :failure_count, :pending_count).new(duration, example_count, failure_count, pending_count)
      formatter.dump_summary(summary)
    else
      formatter.dump_summary(duration, example_count, failure_count, pending_count)
    end
  end
end
