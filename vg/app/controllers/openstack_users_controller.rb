
class OpenstackUsersController < ApplicationController
  before_action :set_openstack_user, only: [:show, :edit, :update, :destroy]

  # GET /openstack_users
  # GET /openstack_users.json
  def index
    session[:updated_floavors] = ""
    @openstack_users = OpenstackUser.all
  end

  # GET /openstack_users/1
  # GET /openstack_users/1.json
  def show
  end

  # GET /openstack_users/new
  def new
    @openstack_user = OpenstackUser.new
  end

  # GET /openstack_users/1/edit
  def edit
  end

  # POST /openstack_users
  # POST /openstack_users.json
  def create
    @openstack_user = OpenstackUser.new(openstack_user_params)

    respond_to do |format|
      if @openstack_user.save
        format.html { redirect_to @openstack_user, notice: 'Openstack user was successfully created.' }
        format.json { render :show, status: :created, location: @openstack_user }
      else
        format.html { render :new }
        format.json { render json: @openstack_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /openstack_users/1
  # PATCH/PUT /openstack_users/1.json
  def update
    respond_to do |format|
      if @openstack_user.update(openstack_user_params)
        format.html { redirect_to @openstack_user, notice: 'Openstack user was successfully updated.' }
        format.json { render :show, status: :ok, location: @openstack_user }
      else
        format.html { render :edit }
        format.json { render json: @openstack_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /openstack_users/1
  # DELETE /openstack_users/1.json
  def destroy
    @openstack_user.destroy
    respond_to do |format|
      format.html { redirect_to openstack_users_url, notice: 'Openstack user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_openstack_user
      @openstack_user = OpenstackUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def openstack_user_params
      params.require(:openstack_user).permit(:os_username, :os_password, :os_auth_url, :chef_server_url, :client_name, :signing_key_file)
    end
end





