require 'rails_helper'

RSpec.describe Api::V1::ToolsController,
  :apidoc, type: :controller,
  resource_group: 'API V1',
  resource: 'Ferramentas [/api/v1/tools]' do

  # [GET /api/v1/tools]
  describe '#index',
    action: 'listar todas as ferramentas cadastradas [GET]',
    action_description: "Este endpoint permite listar todas as ferramentas cadastradas" do

    let!(:tagging) { create(:tagging) }

    context "without tag filter" do
      it "returns all tools" do
        get :index, format: :json
        expect(JSON.parse(response.body).length).to eql 1
        expect(response).to have_http_status(:ok)
      end
    end

    context "with a tag filter" do
      it "returns filtered tools from tag" do
        get :index, :params => { :tag => tagging.tag.name }, format: :json
        expect(JSON.parse(response.body).length).to eql 1
        expect(response).to have_http_status(:ok)
      end
    end
  end

  # [GET /api/v1/tools/1]
  describe '#show',
    resource: 'Ferramentas [/api/v1/tools/:id]',
    action: 'Exibe uma ferramenta [GET]',
    action_description: "Permite exibir uma ferramenta" do

    let!(:tool) { create(:tool) }
    let(:retrieve_tools) { get :show, params: { id: tool.id.to_s }, format: :json }

    it "retorna todas as ferramentas" do
      retrieve_tools
      expect(JSON.parse(response.body)).to match({
        'id' => tool.id,
        'title' => tool.title,
        'link' => tool.link,
        'description' => tool.description,
        'tags' => tool.tag_list
      })

      expect(response).to have_http_status(:ok)
    end
  end

  # [POST /api/v1/tools]
  describe '#create',
    resource: 'Ferramentas [/api/v1/tools]',
    action: 'Cadastra uma ferramenta [POST]',
    action_description: "Permite cadastrar uma ferramenta" do

    let(:create_tool) { post :create, params: { 'title' => 'Test', 'link' => 'http://test.com', 'description' => 'Example', 'tags' => ['test'] }, format: :json }
    let(:create_empty_tool) { post :create, format: :json }

    context 'fails to create a tool' do
      it 'fails to create a tool' do
        expect{ create_empty_tool }.not_to change { Tool.count }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'succeeds in creating a tool' do
      it 'succeeds in creating a tool' do
        expect { create_tool }.to change { Tool.count }
        expect(response).to have_http_status(:created)
      end
    end
  end

  # [DELETE /api/v1/tools/1]
  describe '#destroy',
    resource: 'Ferramentas [/api/v1/tools/:id]',
    action: 'Remove uma ferramenta [DELETE]',
    action_description: "Permite remover uma ferramenta" do

    let!(:tool) { create(:tool) }
    let(:retrieve_tools) { get :destroy, params: { id: tool.id.to_s }, format: :json }

    it "removes a tool" do
      retrieve_tools
      expect(Tool.count).to eql(0)
      expect(response).to have_http_status(:no_content)
    end
  end
end
