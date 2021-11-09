module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_article, only: %i[show update destroy]

      def index
        articles = Article.order('created_at ASC')
        render json: {status: 'success', message: 'Loaded articles', data: articles }, status: :ok
      end

      def show
        render json: {status: 'success', message: 'Article loaded', data: @article}, status: :ok
      end

      def create
        article = Article.new(article_params)

        if article.save
          render json: { status: 'success', message: 'Article saved', data: article }, status: :created
        else
          render json: {status: 'error', message: 'Something went wrong', data: article.errors}, status: :bad_request
        end
      end

      def update
        if @article.update(article_params)
          render json: { status: 'success', message: 'Article updated', data: @article }, status: :ok
        else
          render json: { status: 'error', message: 'Article was not updated!', data: @article.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @article.destroy
        render json: { status: 'success', message: 'Article deleted' }, status: :ok
      end

      private

      def set_article
        @article = Article.find(params[:id])
      end

      def article_params
        params.permit(:title, :body)
      end
    end
  end
end
