class HorsesController < ApplicationController
  before_action :set_horse, only: [:show, :edit, :update, :destroy]

  # GET /horses
  # GET /horses.json
  def index
    if params[:search] && params[:search] != ""
      if params[:search].length > 3 && params[:search][0..2].downcase == "id:"
        id = params[:search][3..params[:search].length - 1].to_i
        @horses = Horse.paginate :page => params[:page], :conditions => ["id = ?", id]
      else
        search = '%' + params[:search].downcase + '%'
        @horses = Horse.paginate :page => params[:page], :conditions => ["name like ?", search], 
        :order => "name"
      end
    else
      @horses = Horse.paginate :page => params[:page], :order => "name"
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
      format.html { redirect_to horses_url, notice: "Horse '#{@horse.name}' was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def tree
    @tree = []
    @names = []
    build_tree(params[:id], 4)
  end

  def ctree
    @tree = []
    @names = []
    build_tree(params[:id], 0)
    @lines = []
    build_ctree
#   @lines.sort!
  end

  def xtree
    @tree = []
    @names = []
    build_tree(params[:id], 0, true)
    @lines = []
    build_ctree
#   @lines.sort!
  end

  def children
    @horses = Horse.paginate :page => params[:page], 
      :conditions => ["sire_id = ? or dam_id = ?", params[:id], params[:id]], :order => "name"
  end

  def complete_sire_name
    horses = Horse.where("sex='h' and name like ?", params[:name] + '%').order(:name)
    render json: horses, :only => [:id, :name]
  end

  def complete_dam_name
    horses = Horse.where("sex='m' and name like ?", params[:name] + '%').order(:name)
    render json: horses, :only => [:id, :name]
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

    def build_tree(id, limit, xtree=false)
      horse = Horse.find(id)
      @tree.clear
      @tree[0] = horse.id
      @names.clear
      @names[0] = horse.name
      gen = 1
      loop until !build_tree_generation(gen, limit, xtree)
    end

    def build_tree_generation(gen, limit, xtree)
      # xtree follows x chrmosones - so father to father is dropped
      found = false
      (2**gen - 1).step(2**(gen+1)-2,2) do |idx|
        horse = Horse.find(@tree[idx/2]) if @tree[idx/2]
     	 if horse && horse.sire && ((xtree && horse.sex == "m") || !xtree)
          @tree[idx] = horse.sire.id
          @names[idx] = horse.sire.name
          found = true
        end
        if horse && horse.dam
          @tree[idx+1] = horse.dam.id
          @names[idx+1] = horse.dam.name
          found = true
        end
      end
      gen += 1
      return nil if !found || (gen > limit && limit != 0)
      build_tree_generation(gen, limit, xtree)
    end

    def build_ctree
      @lines.clear
      generations = Math::log(@names.length, 2).floor
      lines = 2**(generations+1) - 2**generations
      logger.info "Building ctree for #{@names[0]} (#{@tree[0]} gens=#{generations} with lines=#{lines}"
      0.upto(lines-1) do |idx|
        @lines[idx] = ""
      end
      curline = 0
      (2**(generations+1)-2).downto(2**(generations)-1) do |idx|
        if idx %2 == 0
          @lines[curline] = 'M:' +  @lines[curline] if @names[idx]
        else
          @lines[curline] = @names[idx] + ':' +  @lines[curline] if @names[idx]
        end
        parent = (idx-1) / 2
        while parent > 0
          if parent %2 == 0
            @lines[curline] = 'M:' +  @lines[curline] if @names[parent]
          else
            @lines[curline] = @names[parent] + ':' +  @lines[curline] if @names[parent]
          end
          parent = (parent-1) / 2
        end
        curline += 1
      end
      @lines.uniq!
#     @lines.sort!
      compressMares
      makeTable
    end

    def compressMares
      @lines.each do |line|
        if pos = line.index('M:M:')
          count = 0
          while line.slice(pos,2) == "M:"
            count += 1
            pos += 2
          end
          line.sub!("M:" * count, (count-1).to_s + ":") 
          redo
        end
      end
    end

    def makeTable  
      0.upto(@lines.length-1) do |idx|
        @lines[idx] = '<tr><td>' + @lines[idx]
        @lines[idx].chop!
        @lines[idx].gsub!(':','</td><td>')
        @lines[idx] += "</td></tr>"
      end
    end
 
end
