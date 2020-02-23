class Notice
  def self.not_found( record = 'record' )
    "Sorry, #{record} was not found."
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.account_created
    'User created successfully'
  end

  def self.account_not_created
    'User could not be created'
  end

  def self.expired_token
    'Sorry, token has expired. Please login to continue.'
  end

  def self.message_created
    'Message created'
  end

  def self.message_updated
    'Message updated'
  end

  def self.message_deleted
    'Message deleted'
  end
end