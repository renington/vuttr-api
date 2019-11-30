class Api::V1::ToolsController < Api::V1::ApiController
  before_action :set_tool, only: [:show, :update, :destroy]

  # GET /api/v1/tools
  def index
    @tools = params[:tag] ? Tool.tagged_with(params[:tag]) : Tool.all
    render json: @tools, status: :ok
  end
 
  # GET /api/v1/tools/1
  def show
    render json: @tool
  end

  # POST /api/v1/tools
  def create
    @tool = Tool.new(tool_params).add_tags(params[:tags])
    if @tool.save
      render json: @tool, status: :created
    else
      render json: @tool.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tools/1
  def update
    if @tool.update(tool_params)
      render json: @tool, status: :ok
    else
      render json: @tool.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tools/1
  def destroy
    @tool.destroy
  end

  private
  def set_tool
    @tool = Tool.find(params[:id])
  end

  def tool_params
    params.require(:tool).permit(:title, :link, :description)
  end
end