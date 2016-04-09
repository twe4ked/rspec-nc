require 'rspec/core/formatters/base_formatter'
require 'terminal-notifier'

class Nc < RSpec::Core::Formatters::BaseFormatter
  RSpec::Core::Formatters.register self, :dump_summary

  def dump_summary(notification)
    body = "Finished in #{notification.formatted_duration}\n#{notification.totals_line}"
    title = if notification.failure_count > 0
      "\u26D4 #{directory_name}: #{notification.failure_count} failed example#{notification.failure_count == 1 ? nil : 's'}"
    else
      "\u2705 #{directory_name}: Success"
    end
    TerminalNotifier.notify body, title: title
  end

  private

  def directory_name
    File.basename File.expand_path '.'
  end
end
