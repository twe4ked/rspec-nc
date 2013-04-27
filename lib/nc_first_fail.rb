require 'nc'

class NcFirstFail < Nc
  def example_failed(example)
    if @failed_examples.size == 0
      name = File.basename(File.expand_path '.')
      say "\u26D4 #{name}: Failure", "#{example.metadata[:full_description]}\n#{example.exception}"
    end
    super
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    super if failure_count == 0
  end
end
