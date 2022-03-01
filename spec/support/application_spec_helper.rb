module ApplicationSpecHelper

  SUPPORTED_HTTP_METHODS = %i[get put patch post delete].freeze

  def body_json
    JSON.parse(response.body)
  end

  def self.define_send_method(http_methods)
    http_methods.each do |http_method|
      define_method "send_#{http_method}" do |api_path, *send_args|
        new_args = add_header_items(
          { ACCEPT: :'application/json, text/html' },
          *send_args
        )

        send(http_method, api_path, *new_args)
      end
    end
  end

  define_send_method(SUPPORTED_HTTP_METHODS)

  private

  def add_header_items(header_item, *args)
    new_args = args.dup
    has_custom_options = false
    headers = { }

    new_args.each do |new_arg|
      next unless new_arg.is_a?(Hash)
      if new_arg[:headers].blank?
        new_arg[:headers] = headers
      else
        headers = new_arg[:headers]
      end

      has_custom_options = true

      break
    end

    new_args.push(headers: headers) if !has_custom_options
    headers.merge!(header_item)

    new_args
  end

end

RSpec.configure do |c|
  c.include ApplicationSpecHelper
end
