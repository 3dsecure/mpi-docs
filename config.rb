set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

after_configuration do
  sprockets.append_path File.join "#{root}", "bower_components"
end

activate :livereload

set :markdown_engine, :redcarpet

set :markdown,
  :fenced_code_blocks => true, 
  :smartypants => true, 
  :disable_indented_code_blocks => true, 
  :prettify => true, 
  :tables => true, 
  :with_toc_data => true,
  :no_intra_emphasis => true 

# Activate the syntax highlighter
activate :syntax

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets
  set :relative_links, true

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'docs.3dsecure.io' # The name of the S3 bucket you are targetting.
  s3_sync.region                     = 'eu-west-1'     # The AWS region for your bucket.
  s3_sync.delete                     = false # We delete stray files by default.
  s3_sync.after_build                = false # We do not chain after the build step by default.
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.version_bucket             = false
end
