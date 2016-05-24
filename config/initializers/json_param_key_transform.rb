# File: config/initializers/json_param_key_transform.rb
# Transform JSON request param keys from JSON-conventional camelCase to
# Rails-conventional snake_case:
# This is a copy-paste from:
# http://stackoverflow.com/questions/17240106/what-is-the-best-way-to-convert-all-controller-params-from-camelcase-to-snake-ca
ActionDispatch::Request.parameter_parsers[Mime[:json].symbol] = lambda do |raw_post|
  # Modified from action_dispatch/http/parameters.rb
  data = ActiveSupport::JSON.decode(raw_post)
  data = { _json: data } unless data.is_a?(Hash)

  # Transform camelCase param keys to snake_case:
  data.deep_transform_keys!(&:underscore)
end
