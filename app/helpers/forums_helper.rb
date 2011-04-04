module ForumsHelper

  def time_of_last_update_in_this_topic(topic_id)
  	@last_topic = Topic.find_by_sql("SELECT * FROM posts WHERE \"topic_id\"='" + topic_id.to_s + "' ORDER BY created_at DESC LIMIT 1;")
  end
end
