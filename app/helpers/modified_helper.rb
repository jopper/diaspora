#require 'ftools'
require 'time'

module ModifiedHelper
  def last_modified
    git_last='git log -1 --pretty=format:"%ar"'
    filepath = Rails.root.join('tmp', '.last_pull')
    begin
      mtime = File.mtime(filepath)
    rescue Exception => e
      mtime = nil
    end
    if (mtime.nil? || mtime < Time.now-(60*5))
      last=`#{git_last}`
      begin
        f = File.open(filepath, 'w')
        f.puts(last)
        f.close
      rescue  Exception => e
        Rails.log.info("Failed to log git status #{filepath}: #{e}")
      end
    else
      begin
        arr=IO.readlines(filepath)
        last=arr[0]
      rescue Exception => e
        Rails.log.info("Failed to read git status #{filepath}: #{e}")
        last=`#{git_last}`
      end
    end
    return last
  end
end
