class Moving < ApplicationRecord
  belongs_to :client
  belongs_to :mover
  has_many :items, through: :client

  def self.get_distance(origin, destination)

    payload = {
        origins: [{
                      latitude: origin[:lat],
                      longitude: origin[:lng]
                  }],
        destinations: [{
                      latitude: destination[:lat],
                      longitude: destination[:lng]
                  }],
        travelMode: "driving"
    }

    response = RestClient.post("https://dev.virtualearth.net/REST/v1/Routes/DistanceMatrix?key=#{Rails.application.credentials.secret_bing_api_key}", payload.to_json)
    json_response = JSON.parse(response)
    json_response['resourceSets'][0]['resources'][0]['results'][0]['travelDistance']

  end

  def self.get_estimate(distance, moving_type)

    price_factor = case moving_type
    when 'Small Move'
      1
    when 'Room Move'
      1.4
    when 'Apt Move'
      1.7
    else
      return 0
    end

    (43.605 * (distance ** 0.447) * price_factor).ceil
  end
end
