require 'nc_first_fail'

describe NcFirstFail do
  let(:formatter) { NcFirstFail.new(StringIO.new) }
  let(:current_dir) { File.basename(File.expand_path '.') }
  let(:example) { double 'example' }
  let(:example2) { double 'example2' }

  let(:failure) { "\u26D4" }
  let(:exception) { 'exception' }
  let(:description) { 'description' }

  it 'notifies the first failure only' do
    allow(example).to receive(:metadata).and_return({:full_description => description})
    allow(example).to receive(:exception).and_return(exception)

    expect(TerminalNotifier).to receive(:notify).with("#{description}\n#{exception}",
      :title => "#{failure} #{current_dir}: Failure"
    )

    formatter.example_failed(example)
    formatter.example_failed(example2)
  end

  it "doesn't notify in the end if there has been any failures" do
    expect(TerminalNotifier).to_not receive(:notify)

    formatter.dump_summary(0.0001, 2, 1, 0)
  end
end
