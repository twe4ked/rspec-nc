require 'nc'

class NcFirstFail < Nc
  if RSpec::Core::Formatters.respond_to? :register
    RSpec::Core::Formatters.register self, :example_failed
  end

  def example_failed(example)
    @failed_examples ||= []
    if @failed_examples.size == 0
      name = File.basename(File.expand_path '.')
      say "\u26D4 #{name}: Failure", "#{example.metadata[:full_description]}\n#{example.exception}"
    end
    @failed_examples << example
  end

  def dump_summary(duration, example_count, failure_count, pending_count)
    super if failure_count == 0
  end
end
