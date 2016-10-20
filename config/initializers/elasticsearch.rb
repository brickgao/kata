$ELASTICSEARCH_URI = ENV["ELASTICSERACH_HOST"] + ":" + ENV["ELASTICSERACH_PORT"].to_s if ENV["ELASTICSERACH_HOST"]

Elasticsearch::Model.client = Elasticsearch::Client.new(:host => $ELASTICSEARCH_URI || "127.0.0.1", )
