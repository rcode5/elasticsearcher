require 'elasticsearch/extensions/test/cluster'
class TestEsServer
  def self.cluster
    Elasticsearch::Extensions::Test::Cluster
  end

  def self.port
    # Same port used by elasticsearch-extensions/lib/elasticsearch/extensions/test/cluster.rb:82
    @port ||= (ENV.fetch('TEST_CLUSTER_PORT', 9250).to_i)
  end

  def self.running?
    cluster.running?(on: port)
  end

  def self.start
    puts "Starting elastic search cluster on port #{port} if necessary"
    cluster.start(port: port, nodes: 1) unless running?
  end

  def self.stop
    puts "Tearing down elastic search cluster on port #{port} if necessary"
    cluster.stop(port: port) if running?
  end
end
