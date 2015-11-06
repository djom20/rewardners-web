namespace :brakeman do
  desc "Run Brakeman"
  task :run do
    require 'brakeman'
    file_path = './brakeman-report.html'

    tracker   = Brakeman.run :app_path => ".", :exit_on_warn => true, :output_format => :to_html

    File.delete(file_path) if File.exist? file_path
    f = File.new(file_path,'w')
    f.puts(tracker.report.to_html)
    report  = Brakeman::Report.new(".", tracker)
    if tracker.warnings.empty?
      puts "Brakeman scanning finished successfully!! No warnings, see brakeman-report.html for more info"
    else
      raise "Brakeman reported warnings!! see brakeman-report.html for more info"
    end
  end
end
