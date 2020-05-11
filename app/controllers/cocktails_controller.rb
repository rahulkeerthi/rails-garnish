# frozen_string_literal: true

class CocktailsController < ApplicationController
  before_action :set_cocktail, only: %i[show edit update destroy]
  before_action :set_ingredients

  def index
    @cocktails = Cocktail.all.sort_by(&:id)
  end

  def show
    @dose = Dose.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.user = if user_signed_in?
                       current_user
                     else
                       User.first
                     end
    if @cocktail.image_url.nil?
      @cocktail.image_url = 'https://source.unsplash.com/1024x768/?cocktail'
    end
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @cocktail.update(cocktail_params)
      redirect_to cocktail_path(@cocktail)
    else
      render :edit
    end
  end

  def destroy
    if @cocktail.destroy!
      redirect_to cocktails_path, notice: 'Your cocktail has been deleted'
    end
  end

  private

  def set_ingredients
    @ingredients = Ingredient.all
  end

  def set_cocktail
    @cocktail = Cocktail.find(params[:id])
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :description, :glass_id, :category_id)
  end
end
