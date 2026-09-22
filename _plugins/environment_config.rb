# frozen_string_literal: true

# Jekyll exposes `baseurl` as a CLI option but not the canonical site origin.
# Let CI inject the origin reported by actions/configure-pages while retaining a
# useful localhost default for local builds.
Jekyll::Hooks.register :site, :after_init do |site|
  site_url = ENV.fetch("JEKYLL_SITE_URL", "").strip
  site.config["url"] = site_url unless site_url.empty?
end

