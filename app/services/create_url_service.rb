class CreateUrlService
  attr_reader :errors, :url

  SHORT_URL_SIZE = 7 # max size is 32

  def initialize
    reset_instance_variables
  end

  def perform(original_url)
    url = Url.new(original_url: original_url&.strip, short_url: get_short_url)
    unless url.valid?
      @errors = url.errors.messages
      return false
    end
    @url = url.tap { |url| url.save }
    true
  end

  private

  def get_short_url
    while true
      short_url = SecureRandom.hex[0 .. SHORT_URL_SIZE - 1]
      return short_url unless Url.find_by(short_url: short_url)
    end
  end

  def reset_instance_variables
    @errors = {}
    @url = nil
  end
end
