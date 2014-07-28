require 'rspec/core/formatters/base_text_formatter'
require 'terminal-notifier'

class Nc < RSpec::Core::Formatters::BaseTextFormatter
  if RSpec::Core::Formatters.respond_to? :register
    RSpec::Core::Formatters.register self, :dump_summary
  end

  if RSpec::Core::Version::STRING =~ /^3/
    define_method(:dump_summary) do |summary|
      output_summary(summary.duration, summary.example_count, summary.failure_count, summary.pending_count)
    end
  else
    define_method(:dump_summary) do |duration, example_count, failure_count, pending_count|
      output_summary(duration, example_count, failure_count, pending_count)
    end
  end

  def output_summary(duration, example_count, failure_count, pending_count)
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

  unless RSpec::Core::Version::STRING =~ /^3/
    define_method(:dump_pending) { }
    define_method(:dump_failures) { }
    define_method(:message) { |message| }
  end

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
