def json_body
  JSON.parse(response_body)['data']
end

def jwt_decode(token)
  JWT.decode(data, ENV.fetch('JWT_SECRET')).first['data']
end

def jwt_encode(token)
  JWT.encode({data: token}, ENV.fetch('JWT_SECRET'))
end
