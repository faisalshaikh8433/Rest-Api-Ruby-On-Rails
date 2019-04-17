module Api
    module V1
        class ArticlesController < ApplicationController
            skip_before_action :verify_authenticity_token #for escaping authenticity token 
            def index
                @articles = Article.order('created_at DESC')
                render json: {status:'SUCCESS', message: 'Loaded articles', data:@articles},status: :ok
            end
#get
            def show
                @article = Article.find(params[:id])
                render json: {status:'SUCCESS', message: 'Loaded article', data:@article},status: :ok
            end
#post
            def create
                @article = Article.new(article_params)
                if @article.save
                    render json: {status:'SUCCESS', message: 'Saved article', data:@article},status: :ok
                else
                    render json: {status:'ERROR', message: 'Article Not saved', data:@article.errors},status: :unprocessed
                end        
            end
#delete
            def destroy
                @article = Article.find(params[:id])
                @article.destroy
                render json: {status:'SUCCESS', message: 'Deleted article', data:@article},status: :ok
            end
#put 
            def update
              @article = Article.find(params[:id])
              if @article.update_attributes(article_params)
                render json: {status:'SUCCESS', message: 'Updated article', data:@article},status: :ok
              else
                render json: {status:'ERROR', message: 'Article not Updated', data:@article.errors},status: :unprocessed
              end
            end

            private
            def article_params
                params.permit(:title,:body)
            end
        end
    end
end