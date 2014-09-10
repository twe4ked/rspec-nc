require 'nc'

class NcFirstFail < Nc
  if rspec_3?
    RSpec::Core::Formatters.register self, :example_failed
  end

  def example_failed(example)
    # For rspec3
    example = example.example if example.respond_to?(:example)
    @failed_examples ||= []
    if @failed_examples.size == 0
      name = File.basename(File.expand_path '.')
      say "\u26D4 #{name}: Failure", "#{example.metadata[:full_description]}\n#{example.exception}"
    end
    @failed_examples << example
  end

  def dump_summary(*args)
    failure_count = self.class.rspec_3? ? args[0].failure_count : args[2]
    super if failure_count == 0
  end
end
