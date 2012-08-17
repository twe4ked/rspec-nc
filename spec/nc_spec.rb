require 'nc'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = 'doc'
  config.formatter = 'Nc'
end

describe 'it works' do
  it 'returns success' do
    # success!
  end

  it 'returns pending' do
    pending
  end

  it 'returns failure' do
    raise 'the roof'
  end
end
