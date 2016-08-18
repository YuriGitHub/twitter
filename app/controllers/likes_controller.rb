class LikesController < ApplicationController

    def toggle_like
        like = current_user.likes.find_by_post_id(params[:post_id])
        like = Like.new(post_id:params[:post_id],user_id:current_user.id) if like == nil

        old_like = like.like

        if like.like == nil
            like.like = true
        else
            like.like = nil if like.like == true
            like.like = true if like.like == false
        end

        likes_count = nil;
        dislikes_count = nil;
        like.save
        if like.like != old_like
            post = Post.find(params[:post_id])
            likes_count = post.likes.where(like:true).count
            dislikes_count = post.likes.where(like:false).count
        end

        respond_to do |format|
            format.json do
                if like.like == nil
                    render json: {like:'',likes:likes_count,dislikes:dislikes_count}
                else
                    render json: {like:'true',likes:likes_count,dislikes:dislikes_count}
                end
            end
        end
    end


    def toggle_dislike
        like = current_user.likes.find_by_post_id(params[:post_id])
        like = Like.new(post_id:params[:post_id],user_id:current_user.id) if like == nil

        old_like = like.like

        if like.like == nil
            like.like = false
        else
            like.like = nil if like.like == false
            like.like = false if like.like == true
        end

        likes_count = nil;
        dislikes_count = nil;
        like.save
        if like.like != old_like
            post = Post.find(params[:post_id])
            likes_count = post.likes.where(like:true).count
            dislikes_count = post.likes.where(like:false).count
        end

        respond_to do |format|
            format.json do
                if like.like == nil
                    render json: {like:'',likes:likes_count,dislikes:dislikes_count}
                else
                    render json: {like:'false',likes:likes_count,dislikes:dislikes_count}
                end
            end
        end
    end
    

    def upload_like
        post_id = params[:post_id]
        post = Post.find(post_id)
        like = current_user.likes.find_by_post_id(post_id)
        if like == nil
            like = Like.new(post_id:params[:post_id],user_id:current_user.id)
            like.save
        end
        likes_count = post.likes.where(like:true).count
        dislikes_count = post.likes.where(like:false).count
        respond_to do |format|
            format.json do
                if like.like == nil
                    render json: {like:'',likes:likes_count,dislikes:dislikes_count} if like.like == nil
                else
                    render json: {like:'true',likes:likes_count,dislikes:dislikes_count} if like.like == true
                    render json: {like:'false',likes:likes_count,dislikes:dislikes_count} if like.like == false
                end
            end
        end
    end

    def index
        @post = Post.find(1)
    end

end
