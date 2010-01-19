# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_lamatel_session',
  :secret      => '4aa9e0e714706193d9f91e4b2b1f6e3358e88de04e3faac7de779e5e78e9e617ba297ea34fe528f80a89105009084502a25768dfeb0962661e8332d5fd40e493'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store