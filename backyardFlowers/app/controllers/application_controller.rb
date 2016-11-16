class ApplicationController < ActionController::API
  def authenticate
     render json: {status: 401, message: "nope, sorry"} unless decode_token(bearer_token)
   end

   def bearer_token
     pattern = /^Bearer /
     header = request.env["HTTP_AUTHORIZATION"] #<=env
     header.gsub(pattern, '') if header && header.match(pattern)
   end

   def current_user
     return if !bearer_token
     decode_jwt = decode_token(request.env["HTTP_AUTHORIZATION"])
     User.find(decoded_jwt.user.id)
   end

   def decode_token(token)
     token = JWT.decode(token, nil, false)
   rescue
     render json: {status: 401, message: 'invalid or expired token'}
   end
end
