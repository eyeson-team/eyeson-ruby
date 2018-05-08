module Eyeson
  # Get room snapshots
  class Snapshot
    class NotFound < StandardError
    end

    attr_reader :id, :url

    def initialize(id, url)
      @id = id
      @url = url
    end

    def delete
      Eyeson.delete "/snapshots/#{id}"
    end

    def self.find(snapshot_id)
      response = Eyeson.get("/snapshots/#{snapshot_id}")
      links    = response['links']
      raise NotFound if links.nil?
      Snapshot.new snapshot_id, links['download']
    end
  end
end
