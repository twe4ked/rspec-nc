require 'nc'

class NcFail < Nc
  def say(title, body)
    return if @failed_examples.size <= 0
    super
  end
end
