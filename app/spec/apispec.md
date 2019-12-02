# Group API V1
# Ferramentas [/api/v1/tools]
## listar todas as ferramentas cadastradas [GET]

Este endpoint permite listar todas as ferramentas cadastradas

+ Request without tag filter returns all tools

        {}

        Location: ./spec/controllers/tools_controller_spec.rb
        Source code:

              it "returns all tools" do
                get :index, format: :json
                expect(JSON.parse(response.body).length).to eql 1
                expect(response).to have_http_status(:ok)
              end

+ Response 200 (application/json)

        [{"id":402,"title":"VSCode","link":"http://www.google.com","description":"default text","tags":["Node"]}]

+ Request with a tag filter returns filtered tools from tag

        {"tag":"Node"}

        Location: ./spec/controllers/tools_controller_spec.rb
        Source code:

              it "returns filtered tools from tag" do
                get :index, :params => { :tag => tagging.tag.name }, format: :json
                expect(JSON.parse(response.body).length).to eql 1
                expect(response).to have_http_status(:ok)
              end

+ Response 200 (application/json)

        [{"id":403,"title":"VSCode","link":"http://www.google.com","description":"default text","tags":["Node"]}]

## Cadastra uma ferramenta [POST]

Permite cadastrar uma ferramenta

+ Request fails to create a tool fails to create a tool

        {}

        Location: ./spec/controllers/tools_controller_spec.rb
        Source code:

              it 'fails to create a tool' do
                expect{ create_empty_tool }.not_to change { Tool.count }
                expect(response).to have_http_status(:unprocessable_entity)
              end

+ Response 422 (application/json)

        {"title":["can't be blank"]}

+ Request succeeds in creating a tool succeeds in creating a tool

        {"description":"Example","link":"http://test.com","tags":["test"],"title":"Test"}

        Location: ./spec/controllers/tools_controller_spec.rb
        Source code:

              it 'succeeds in creating a tool' do
                expect { create_tool }.to change { Tool.count }
                expect(response).to have_http_status(:created)
              end

+ Response 201 (application/json)

        {"id":405,"title":"Test","link":"http://test.com","description":"Example","tags":["test"]}

# Ferramentas [/api/v1/tools/:id]
## Exibe uma ferramenta [GET]

Permite exibir uma ferramenta

+ Request retorna todas as ferramentas

        {}

        Location: ./spec/controllers/tools_controller_spec.rb
        Source code:

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

+ Response 200 (application/json)

        {"id":404,"title":"VSCode","link":"http://www.google.com","description":"default text","tags":[]}

## Remove uma ferramenta [DELETE]

Permite remover uma ferramenta

+ Request removes a tool

        {}

        Location: ./spec/controllers/tools_controller_spec.rb
        Source code:

            it "removes a tool" do
              retrieve_tools
              expect(Tool.count).to eql(0)
              expect(response).to have_http_status(:no_content)
            end

+ Response 204 (application/json)

         

