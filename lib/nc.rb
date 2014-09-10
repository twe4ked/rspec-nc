require 'rspec/core/formatters/base_text_formatter'
require 'terminal-notifier'

class Nc < RSpec::Core::Formatters::BaseTextFormatter

  def self.rspec_3?
    RSpec::Core::Version::STRING.split('.').first == "3"
  end

  if rspec_3?
    RSpec::Core::Formatters.register self, :dump_summary
  end

  def dump_summary(*args)
    if self.class.rspec_3?
      notification = args[0]
      duration = notification.duration
      example_count = notification.example_count
      failure_count = notification.failure_count
      pending_count = notification.pending_count
    else
      duration, example_count, failure_count, pending_count = args
    end

    body = []
    body << "Finished in #{_format_duration duration}"
    body << _summary_line(example_count, failure_count, pending_count)

    name = File.basename(File.expand_path '.')

    title = if failure_count > 0
      "\u26D4 #{name}: #{failure_count} failed example#{failure_count == 1 ? nil : 's'}"
    else
      "\u2705 #{name}: Success"
    end

    say title, body.join("\n")
  end

  def dump_pending(*args); end
  def dump_failures(*args); end
  def message(message); end

  private

  def say(title, body)
    TerminalNotifier.notify body, :title => title
  end

  def _format_duration(duration)
    if respond_to? :format_duration
      format_duration duration
    else
      require 'rspec/core/formatters/helpers'
      RSpec::Core::Formatters::Helpers.format_duration duration
    end
  end

  def _summary_line(example_count, failure_count, pending_count)
    if respond_to? :summary_line
      summary_line(example_count, failure_count, pending_count)
    else
      RSpec::Core::Notifications::SummaryNotification.new(
        nil,
        SizeResponder.new(example_count),
        SizeResponder.new(failure_count),
        SizeResponder.new(pending_count),
        nil
      ).totals_line
    end
  end

  SizeResponder = Struct.new(:size)
end
