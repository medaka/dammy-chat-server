class Apis::PostsController < Apis::BaseController
  before_action :authenticate_user!
  def index
    posts = Post
            .all
            .last(20)
            .map{|p| p.render_message }
    render json: posts
  end
  
  def commit
    json_req = JSON.parse(request.body.read, {:symbolize_names => true})
    current_user.posts.create(message: json_req[:message])
    posts = Post
            .all
            .last(20)
            .map{|p| p.render_message }
    render json: posts
  end
end
