class PortfoliosController < ApplicationController
  layout "portfolio"
  access all: [:show, :index, :angular], user: {except: [:destroy, :new, :create, :update, :edit, :sort]}, site_admin: :all

  def index
    @portfolio_items = Portfolio.by_position
  end

  def sort
     params[:order].each do |key, value|
      Portfolio.find(value[:id]).update(position: value[:position])
     end
     render nothing: true # we cominucated with the database we do not need to go to try render view 
  end

  def angular
    @angular_portfolio_items = Portfolio.angular
  end

  def new
    @portfolio_item = Portfolio.new
  end

  def create
    @portfolio_item = Portfolio.new(portfolio_params)
    respond_to do |format|
      if @portfolio_item.save
        format.html {redirect_to portfolios_path, notice: 'Portfolio was successfully created.' }
      else
        format.html { render :new}
      end
    end
  end
  

  def edit
    set_portfolio
  end

  def update
    set_portfolio
    respond_to do |format|
      if @portfolio_item.update(portfolio_params)
        format.html {redirect_to portfolios_path, notice: "This item successfully updated."}
      else
        format.html {render 'new'}
      end
    end
  end

  def show
    set_portfolio
  end
  def destroy
    # Perfom the lookup
    set_portfolio
    # Destryo/delete the record
    @portfolio_item.destroy
    # Redirect
    respond_to do |format|
      format.html {redirect_to portfolios_url, notice: "Record was removed."}
    end
  end
  private
  def portfolio_params
    params.require(:portfolio).permit(:title, :subtitle, :body, :main_image, :thumb_image, technologies_attributes: [:id, :name, :_destroy])
  end
  def set_portfolio
    @portfolio_item = Portfolio.find(params[:id])
  end
end
