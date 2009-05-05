# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_glodomor_session',
  :secret      => '7bbce496c4f69577cc4244ecb0e4c525d74d31ca035153a7c30e9976f26f740d1e27592d1c0a6fff2df8e43d1073b9e3d577c92ba77b1d472b2dcc21897a8805'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
