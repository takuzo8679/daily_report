require 'net/http'
require 'uri'
require 'json'

module LogFormatter
  def self.format_log
    uri = URI.parse('https://samples.jnito.com/access-log.json')
    json = Net::HTTP.get(uri)
    log_data = JSON.parse(json, symbolize_names: true)
    # pp log_data
    log_data.map do |data|
      case data
        in {status: 404|500 => status, request_id:, path:, error:}
          "[ERROR] request_id=#{request_id}, path=#{path}, status=#{status}, error=#{error}"
        in {duration: 1000.. => duration, request_id:, path:}
          "[WARN] request_id=#{request_id}, path=#{path}, duration=#{duration}"
        in {request_id:, path:}
          "[OK] request_id=#{request_id}, path=#{path}"
        else
          "No match pattern"
      end
  end.join("\n")
  end
end

# {:request_id=>"1", :path=>"/products/1", :status=>200, :duration=>651.7},
# {:request_id=>"2", :path=>"/wp-login.php", :status=>404, :duration=>48.1, :error=>"Not found"},
# {:request_id=>"3", :path=>"/products", :status=>200, :duration=>1023.8},
# {:request_id=>"4", :path=>"/dangerous", :status=>500, :duration=>43.6, :error=>"Internal server error"}


# [OK]request_id=1,path=/products/1
# [ERROR]request_id=2,path=/wplogin.php,status=404,error=Notfound
# [WARN]request_id=3,path=/products,duration=1023.8
# [ERROR]request_id=4, path=/dangerous, status=500, error=Internalservererror
