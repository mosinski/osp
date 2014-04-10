require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Osp
  class Application < Rails::Application
    config.after_initialize do
      Disqus::defaults[:account] = ENV['disqus_shortname']
      Disqus::defaults[:developer] = true
      Disqus::defaults[:container_id] = "disqus_thread"
      Disqus::defaults[:show_powered_by] = false
    end

    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
    config.assets.paths << "#{Rails.root}/vendor/assets/fonts"
    config.assets.precompile += %w( .svg .eot .woff .ttf )
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.time_zone = 'Warsaw'
  end
end
