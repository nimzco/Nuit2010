# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => 'nuit',
  :secret      => 'dcbd4c1bc9e1190b8707870441b8a553a0b6bfa7a8ee4e045ca1a7223357bd5e05725e316f2adedb958db1997b65be21a8ce681e6dcf5b0414ef03d0a5203510'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
