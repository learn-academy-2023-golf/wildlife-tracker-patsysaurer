# Wild Bird Tracker Challenge

The existing cacao plantation in Southeastern Mexico is considering a proposal to plant more trees to expand the chocolate market. Before they give the go ahead, they need to do an environmental impact study. They've asked you to build an API the farmers can use to report bird sightings to customize their farm management strategy.


## Bird Starter Data

Phalacrocoracidae = <i>Phalacrocorax brasilianus</i>

Ardeidae = <i>Bubulcus ibis</i>

Scolopacidae = <i>Calidris minutilla</i>

Cathartidae = <i>Sacoramphus papa</i>

### Manage the Birds to Track in a Database
- Create a resource for bird with two columns: common name and scientific name and their data types:

        $ rails g resource Bird common_name: string scientific_name: string

- Enter the Ruby console: 

        $ rails c

- See the data response for all of the birds (It should be an empty array)
    
        > Bird.all

- Enter the bird starter data:

        > Bird.create(common_name: 'Phalacrocoracidae', scientfic_name: 'Phalacrocorax brasilianus')


## API Restful Routes

### Index
To get a list of all data and renders it in JSON format:

1. Create an index method in the controller

        class BirdsController < ApplicationController
            def index
                birds = Bird.all 
                render json: birds 
            end
        end

2. Run the server

        $ rails s

3.  Send API request to get data:
    - Open Postman app
    - Set to GET
    - Enter the URL: localhost:3000/birds
    - Send
    
    Ensure the format is set to JSON

            [
                {
                    "id": 1,
                    "common_name": "Phalacrocoracidae",
                    "scientific_name": "Phalacrocorax Brasilianus",
                    "created_at": "2023-11-30T18:21:21.217Z",
                    "updated_at": "2023-11-30T18:21:21.217Z"
                },
                {
                    "id": 2,
                    "common_name": "Ardeidae",
                    "scientific_name": "Bubulcus Ibis",
                    "created_at": "2023-11-30T18:22:20.905Z",
                    "updated_at": "2023-11-30T18:22:20.905Z"
                },
                {
                    "id": 3,
                    "common_name": "Scolopacidae",
                    "scientific_name": "Calidris Minutilla",
                    "created_at": "2023-11-30T18:23:07.228Z",
                    "updated_at": "2023-11-30T18:23:07.228Z"
                },
                {
                    "id": 4,
                    "common_name": "Cathartide",
                    "scientific_name": "Sacoramphus Papa",
                    "created_at": "2023-11-30T18:24:20.769Z",
                    "updated_at": "2023-11-30T18:24:20.769Z"
                },
                {
                    "id": 5,
                    "common_name": "Ciconiidae",
                    "scientific_name": "Mycteria Americana",
                    "created_at": "2023-11-30T18:34:13.313Z",
                    "updated_at": "2023-11-30T18:34:13.313Z"
                },
                {
                    "id": 6,
                    "common_name": "Falconiday",
                    "scientific_name": "Herpetotheres Cachinnas",
                    "created_at": "2023-11-30T18:36:26.329Z",
                    "updated_at": "2023-11-30T18:36:26.329Z"
                }
            ]
              
***
### Show
To show a single instance of the data:

1. Create a show method in the controller

            def show
                bird = Bird.find(params[:id])
                render json: bird
            end

2. Send an API request to get data:
- Open Postman app
- Set to GET  
- Enter the URL, the route path and ID number: localhost:3000/birds/1
- Send

            {
                "id": 1,
                "common_name": "Phalacrocoracidae",
                "scientific_name": "Phalacrocorax Brasilianus",
                "created_at": "2023-11-30T18:21:21.217Z",
                "updated_at": "2023-11-30T18:21:21.217Z"
            }
***
### Create

To allow the user to create a new type of bird in the database.

Note: 
- Add a strong params method for extra security since the user is involved.
- Call it inside the create method to connect them.

1. Create a create method in the controller

            def create 
                bird = Bird.create(bird_params)
            end 

            private
            def bird_params
                params.require(:bird).permit(:common_name, :scientific_name)
            end
2. Setup an error message inside the create method to help troubleshoot: 

            def create
                bird = Bird.create(bird_params)
                if bird.valid?
                    render json: bird
                else 
                    render json: bird.errors
                end
            end

3. Send API request to post data: 
- Open Postman app
- Set to POST 
- Select the Body tab
- Select raw > change TEXT to JSON
- Enter a new data object:
            
            {
                "common_name": "Accipitridae",
                "scientific_name": "Leptodon Cayanensis"
            }

- Disable authenticity token (this will allow rails and Postman to interact with each other)

            class ApplicationController < ActionController::Base 
                skip_before_action :verify_authenticity_token
            end

- Send


## Update 

To update an existing bird in the database.

1. Create an update method in the controller

            def update
                bird = Bird.find(params[:id])
                bird.update(bird_params)
                if bird.valid?
                    render json: bird
                else 
                    render json: bird.errors
                end
            end

2. Send API request to update data
- Open Postman app
- Set to PATCH 
- Enter URL and id: localhost:3000/birds/id
- Update the JSON (change the "y" to an "e" on "Falconidae" )


        {
            "common_name": "Falconidae",
            "scientific_name": "Herpetotheres Cachinnas"
        }

## Destroy

To remove an existing bird from the database.

1. Create a destroy method in the controller: 

            def destroy 
                bird = Bird.find(params[:id])
                if bird.destroy?
                    render json: bird
                else 
                    render json: bird.errors
                end
            end 

2. Send API request to destroy data:
- Open Postman app
- Set to DELETE
- Enter URL and id: localhost:3000/birds/7
- Send
- Confirm in the terminal it was deleted

        Bird Destroy (0.4ms)  DELETE FROM "birds" WHERE "birds"."id" = $1  [["id", 7]]



