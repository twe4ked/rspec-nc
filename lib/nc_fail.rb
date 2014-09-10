require 'nc'

class NcFail < Nc
  if rspec_3?
    RSpec::Core::Formatters.register self, :example_failed
  end

  def say(title, body)
    @failed_examples ||= []
    return if @failed_examples.size <= 0
    super
  end

  def example_failed(failure)
    @failed_examples ||= []
    @failed_examples << failure
  end
end
