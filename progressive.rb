require 'ruby-progressbar'

module Progressive

  def self.new total=100
    ProgressBar.create(total: total)
  end

  def progress_bar total=100
    @progress_bar ||= Progressive.new(100)
  end
end
