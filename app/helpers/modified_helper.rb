require 'ftools'
require 'time'

module ModifiedHelper
  def last_modified
    #filepath = Rails.root.join('tmp', '.last_pull');
    #if (File.mtime(filepath) > Time.now-(60*5))
    #end
    `git log -1 --pretty=format:"%ar"`
  end
end
