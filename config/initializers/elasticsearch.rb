if File.exist?(".In_Container")
    ELASTICSEARCH_URI = "elasticsearch.local:9200"
    Elasticsearch::Model.client = Elasticsearch::Client.new host: ELASTICSEARCH_URI
end
