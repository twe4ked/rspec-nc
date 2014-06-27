require 'nc'

class NcFail < Nc
  def say(title, body)
    @failed_examples ||= []
    return if @failed_examples.size <= 0
    super
  end

  def example_failed(failure)
    @failed_examples << failure
  end
end
