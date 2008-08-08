# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = true


# This assumes you have set up memcached. If you haven't
# follow these instructions.

# Installing Memcached
# @topfunky :: http://nubyonrails.com/articles/2006/08/17/memcached-basics-for-rails

config.cache_store = :mem_cache_store, '127.0.0.1:11211'
CACHE_TIMEOUT = 10.seconds


# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

