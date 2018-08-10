# Client for CDNsun CDN API

SYSTEM REQUIREMENTS

* Ruby >= 2.1
* httparty

GEM

https://rubygems.org/gems/cdn_api_client

CDN API DOCUMENTATION

https://cdnsun.com/knowledgebase/api

CLIENT USAGE

* Initialize the client
```
require 'cdn_api_client'

client = CDNsunCdnApiClient.new(
  username: 'YOUR_API_USERNAME',
  password: 'YOUR_API_PASSWORD'
)
```

* Get CDN service reports (https://cdnsun.com/knowledgebase/api/documentation/res/cdn/act/reports)
```
client.get(url: 'cdns/ID/reports', data: { type: 'GB', period: '4h'})
```
* Purge CDN service content (https://cdnsun.com/knowledgebase/api/documentation/res/cdn/act/purge)

```
client.post(url: 'cdns/ID/purge', data: { purge_paths: [ '/path1.img', '/path2.img'] })
```

NOTES

* The ID stands for a CDN service ID, it is an integer number, eg. 123, to find your CDN service ID please visit the Services/How-To (https://cdnsun.com/cdn/how-to) page in the CDNsun CDN dashboard.

CONTACT

* W: https://cdnsun.com
* E: info@cdnsun.com

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org/gems/cdn_api_client).
