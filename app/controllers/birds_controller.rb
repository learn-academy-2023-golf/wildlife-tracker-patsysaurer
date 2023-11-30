class BirdsController < ApplicationController
    def index
        birds = Bird.all 
        render json: birds 
    end

    def show
        bird = Bird.find(params[:id])
        render json: bird
    end

    def create 
        bird = Bird.create(bird_params)
        if bird.valid?
            render json: bird
        else 
            render json: bird.errors
        end
    end 

    def update
        bird = Bird.find(params[:id])
        bird.update(bird_params)
        if bird.valid?
            render json: bird
        else 
            render json: bird.errors
        end
    end

    def destroy 
        bird = Bird.find(params[:id])
        if bird.destroy
            render json: bird
        else 
            render json: bird.errors
        end
    end 

    private
    def bird_params
        params.require(:bird).permit(:common_name, :scientific_name)
    end
end
