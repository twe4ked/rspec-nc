require 'nc'

class NcFail < Nc
  if RSpec::Core::Formatters.respond_to? :register
    RSpec::Core::Formatters.register self, :example_failed
  end

  def initialize(_)
    @failed_examples ||= []
    super
  end

  def say(title, body)
    return if @failed_examples.size <= 0
    super
  end

  def example_failed(failure)
    @failed_examples << failure
  end
end
