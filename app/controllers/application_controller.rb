class ApplicationController < ActionController::API

  def validate!(param_class, data = params)
    param = param_class.new(data)

    raise StandardError "#{param} invalid, error: #{param.errors}" unless param.valid?

    param
  end

end
