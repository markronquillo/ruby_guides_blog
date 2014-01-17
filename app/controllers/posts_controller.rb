class PostsController < ApplicationController
	http_basic_authenticate_with name: 'mark', password: 'secret', except: [:index, :show]

	def index 
		@posts = Post.all
	end

	def new 
		@post = Post.new # the reason why we add this line is because the error trapping will throw an error if @post is nil (@post.error.any?)
	end

	def show
		@post = Post.find(params[:id])
	end

	def create
		# render text: params[:post].inspect
		@post = Post.new(post_params)
		if @post.save
			redirect_to action: :show, id: @post.id
		else
			render 'new'
		end 
	end

	def edit
		@post = Post.find(params[:id]) 
	end

	def update
		@post = Post.find(params[:id]);

		if @post.update(params[:post].permit(:title, :text))
			redirect_to @post
		else
			render 'edit'
		end 
	end

	def destroy 
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to posts_path
	end	

	private 
		def post_params
			params.require(:post).permit(:title, :text)
		end
end
