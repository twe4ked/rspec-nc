require 'rspec/core/formatters/base_text_formatter'
require 'terminal-notifier'

class Nc < RSpec::Core::Formatters::BaseTextFormatter
  def dump_summary(duration, example_count, failure_count, pending_count)
    say "Finished in #{duration} seconds", summary_line(example_count, failure_count, pending_count)
  end

  def dump_pending; end
  def dump_failures; end

  private

  def say(title, body)
    TerminalNotifier.notify body, :title => title
  end
end
