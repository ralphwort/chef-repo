class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]

  # GET /nodes
  # GET /nodes.json
  def index
    if (params[:openstack_user].present?)
      session[:openstack_user] = params[:openstack_user]
      @openstack = Openstackapi.new(params[:openstack_user])
      if (session[:updated_floavors] == "")
        session[:updated_floavors] = "populated"
        @openstack.populate_flavors
      end
      @nodes = Node.for_openstack_user(params[:openstack_user])
      @flavors = Array.new
      @images = Array.new
      @volumes = Array.new
      @ipaddresses = Array.new
      @nodes.each do |node|
        @flavors.push(node.flavor)
        @images.push(node.image)
        @volumes.push(node.volume)
        @ipaddresses.push(node.ipaddress)
      end
    else
      session[:openstack_user] = ""
      @nodes = Node.all
    end
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
  end

  # GET /nodes/new
  def new
    @node = Node.new
  end

  # GET /nodes/1/edit
  def edit
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = Node.new(node_params)

    respond_to do |format|
      if @node.save
        format.html { redirect_to nodes_url(:openstack_user => session[:openstack_user]), notice: 'Node was successfully created.' }
        format.json { render :show, status: :created, location: @node }
      else
        format.html { render :new }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to nodes_url(:openstack_user => session[:openstack_user]), notice: 'Node was successfully updated.' }
        format.json { render :show, status: :ok, location: @node }
      else
        format.html { render :edit }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node.destroy
    respond_to do |format|
      format.html { redirect_to nodes_url(:openstack_user => session[:openstack_user]), notice: 'Node was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = Node.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_params
      params.require(:node).permit(:openstack_user_id, :name, :recipe, :apps)
    end

end
