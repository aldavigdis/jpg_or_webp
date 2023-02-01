# frozen_string_literal: true

require 'browser'

class JpgOrWebp
  VERSION            = '0.1.0'
  DEFAULT_FORMAT     = 'webp' # Defaulting on using WebP.
  DEFAULT_USER_AGENT = 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; ' \
                       'Trident/4.0)' # Yes, it's IE. Don't kinkshame me.

  def initialize(user_agent = DEFAULT_USER_AGENT)
    @user_agent = user_agent
    @browser    = Browser.new(@user_agent)
  end

  def image_format
    return 'jpg' if @browser.ie?
    return 'jpg' if @browser.safari? && @browser.platform.mac?('<11.6')
    return 'jpg' if @browser.platform.ios?('<14')
    return 'jpg' if @browser.platform.kai_os?

    DEFAULT_FORMAT
  end
end
