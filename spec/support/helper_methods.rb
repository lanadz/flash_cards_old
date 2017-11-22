def json_body
  JSON.parse(response_body)['data']
end

def jwt_decode(data)
  JWT.decode(data, ENV.fetch('JWT_SECRET')).first
end

def jwt_encode(data)
  JWT.encode({data: data}, ENV.fetch('JWT_SECRET'))
end
