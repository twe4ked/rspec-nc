require 'rspec/core/formatters/base_text_formatter'
require 'terminal-notifier'

class Nc < RSpec::Core::Formatters::BaseTextFormatter
  def dump_summary(duration, example_count, failure_count, pending_count)
    body = []
    body << "Finished in #{format_duration duration}"
    body << summary_line(example_count, failure_count, pending_count)

    title = if failure_count > 0
      "\u26D4 #{failure_count} failed example#{failure_count == 1 ? nil : 's'}"
    else
      "\u2705 Success"
    end

    say title, body.join("\n")
  end

  def dump_pending; end
  def dump_failures; end

  private

  def say(title, body)
    TerminalNotifier.notify body, :title => title
  end
end
