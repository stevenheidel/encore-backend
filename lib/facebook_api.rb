class FacebookAPI
  def self.get_public_info(facebook_id)
    begin
      response = JSON.parse(conn.get("/" + facebook_id).body)
      response["error"].nil? ? response : nil
    rescue
      nil
    end
  end

  private
  def self.conn
    @@conn ||= Faraday.new(:url => "http://graph.facebook.com/")
  end
end