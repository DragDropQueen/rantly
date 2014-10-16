require 'elasticsearch'

class SetUpElasticSearch < ActiveRecord::Migration
  def change
    Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV['search_url'], log: true

    Rant.import
    User.import
  end
end
