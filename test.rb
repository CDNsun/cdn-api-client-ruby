require_relative "lib/cdn_api_client"

username   = 'YOUR_API_USERNAME';
password   = 'YOUR_API_PASSWORD';
id         = 'YOUR_CDN_SERVICE_ID';

client = CDNsunCdnApiClient.new(username: username, password: password)

response = client.get(url: "cdns")

p response

response = client.get(url: "cdns/#{id}/reports", data: { type: 'GB', period: '4h'})

p response

response = client.post(url: "cdns/#{id}/purge", data: { purge_paths: ['/path1.img', '/path2.img'] })

p response
