class HorsesController < ApplicationController
  before_action :set_horse, only: [:show, :edit, :update, :destroy]

  # GET /horses
  # GET /horses.json
  def index
    if params[:search] && params[:search] != ""
      @horses = Horse.where("name like '%#{params[:search].downcase}%'")
    else
      @horses = Horse.order("name")
    end
  end

  # GET /horses/1
  # GET /horses/1.json
  def show
  end

  # GET /horses/new
  def new
    @horse = Horse.new
  end

  # GET /horses/1/edit
  def edit
  end

  # POST /horses
  # POST /horses.json
  def create
    @horse = Horse.new(horse_params)

    respond_to do |format|
      if @horse.save
        format.html { redirect_to @horse, notice: 'Horse was successfully created.' }
        format.json { render action: 'show', status: :created, location: @horse }
      else
        format.html { render action: 'new' }
        format.json { render json: @horse.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /horses/1
  # PATCH/PUT /horses/1.json
  def update
    respond_to do |format|
      if @horse.update(horse_params)
        format.html { redirect_to @horse, notice: 'Horse was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @horse.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /horses/1
  # DELETE /horses/1.json
  def destroy
    @horse.destroy
    respond_to do |format|
      format.html { redirect_to horses_url }
      format.json { head :no_content }
    end
  end

  def tree
    @tree = []
    @names = []
    build_tree(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_horse
      @horse = Horse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def horse_params
      params.require(:horse).permit(:name, :sex, :year, :sire_id, :dam_id)
    end

    def build_tree_generation(gen)
      found = false
      (2**gen - 1).step(2**(gen+1)-2,2) do |idx|
        horse = Horse.find(@tree[idx/2])
	if horse.sire
          @tree[idx] = horse.sire.id
          @names[idx] = horse.sire.name
	  found = true
	end
	if horse.dam
          @tree[idx+1] = horse.dam.id
          @names[idx+1] = horse.dam.name
	  found = true
	end
      end
      gen += 1
      return nil if !found
      build_tree_generation(gen)
    end

    def build_tree(id)
      horse = Horse.find(id)
      @tree.clear
      @tree[0] = horse.id
      @names.clear
      @names[0] = horse.name
      gen = 1
      loop until !build_tree_generation(gen)
    end

end
