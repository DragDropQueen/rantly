require 'elasticsearch/model'

module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings(
      {
        index: {
          number_of_shards: 1
        },
        analysis: {
          filter: {
            rant_filter: {
              type: 'word_delimiter',
              type_table: ['# => ALPHA', '@ => ALPHA']
            }
          }
        },
        analyzer:
          {rant_analyzer: {
            type: 'custom',
            tokenizer: 'whitespace',
            filter: ['rant_filter']
          }
          }
      }) do
      mappings({
                 dynamic: 'false',
                 rant: {
                   properties: {
                     msg: {
                       type: 'string',
                       analyzer: 'rant_analyzer'
                     }
                   }
                 }}) do
        indexes :title, index_options: 'offsets'
      end
    end
  end
end