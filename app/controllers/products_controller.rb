class ProductsController < ApplicationController
  include ProductsHelper
  allow_unauthenticated_access only: %i[ index show]
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :remove_exif, only: %i[ create update ]

  # GET /products or /products.json
  def index
    @products = authenticated? ? Current.user.products : []
    # @products = authenticated? ? Current.user.products.sorted : []
    @other_products = authenticated? ? Product.where.not(user_id: Current.user.id).sorted : Product.all.sorted

    if params[:sort_by].present? && params[:direction].present?
      sort_columns = params[:sort_by]
      sort_directions = params[:direction]

      # sort_columns.each_pair do |pair|
      #   direction = sort_directions[pair[0]] == "desc" ? "desc" : "asc"
      #
      #   @products = @products.order("#{pair[1]} #{direction}")
      # end

      sort_columns.each_with_index do |column, index|
        direction = sort_directions[index] == "desc" ? "desc" : "asc"

        @products = @products.order("#{column} #{direction}")
      end
      @data = manhandle_query_params(params[:sort_by], params[:direction])
    end

    if params[:popup_for].present?
      @popup = params[:popup_for]
    end
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    redirect_to product_path(@product) if Current.user.id != @product.user.id
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = Current.session.user.id

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    if Current.user.id != @product.user.id
      redirect_to product_path(@product)
      return
    end

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    if Current.user.id != @product.user.id
      redirect_to product_path(@product)
      return
    end

    @product.destroy!

    respond_to do |format|
      format.html { redirect_to products_path, status: :see_other, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :date_bought, :place_bought, :calories, :protein, :carbohydrates,
                                    :fats, :total_weight, :weight_for_macros, :price, :image)
  end

  def remove_exif
    image = product_params[:image]
    return if image.nil? || image.content_type != "image/jpeg"
    ImageProcessing::MiniMagick
      .source(image)
      .strip
      .call(destination: image.tempfile.path)
  end
end
