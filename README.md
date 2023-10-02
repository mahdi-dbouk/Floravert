<img src="./readme/title1.svg"/>

<br><br>

<img src="./readme/table_of_contet.svg">
 <br>

- <span style="font-size:24px;">[User Stories](#user-stories)</span>
- <span style="font-size:24px;">[Prototyping](#mockups)</span>
- <span style="font-size:24px;">[Implementation](#user-screens)</span>
- <span style="font-size:24px;">[Tech Stack](#floravert-is-built-using-the-following-technologies)</span>
- <span style="font-size:24px;">[How to Run](#prerequisites)</span>

<br><br>

<!-- project philosophy -->
<img src="./readme/title2.svg"/>

> A mobile app to help outdoor explorers, plant enthusiasts, and curious souls to identify plants, get rich descriptions, pin to map, and be able purchase plant based goods all within one place.
>
> Floravert aims at empowering nature enthusiasts with seamless plant identification, comprehensive descriptions, and a convenient marketplace, all in one app.
Enabling outdoor explorers to effortlessly connect with the plant world, fostering curiosity and appreciation for nature's wonders.
Streamlining the plant discovery journey, from identification to purchase, for a fulfilling and immersive experience in the great outdoors.

### User Stories
- As a user, I want to open the camera, so I can scan any plant I want.
- As a user, I want a full and rich description of the plants I scan, so I can learn more about them.
- As a user I want to save the scan results, so I can check them later.
- As a user, I want to navigate to store, so I can order any plant based item I want.
- As a user, I want to be able to discover areas where other uses found specific plants on a map, so I can avoid wasting my time foraging in the wrong areas.
- As a trader, I want to be able to sell the plants I foraged, in both processed or raw form, so I that I could benefit from my hobby.
-As a user, I want to be able to message traders, so I can order the product.

<br><br>

<!-- Prototyping -->
<img src="./readme/title3.svg"/>

> We designed Floravert using wireframes and mockups, iterating on the design until we reached the ideal layout for easy navigation and a seamless user experience.


### Mockups
| Landing screen  | Login screen  | Home Screen |
| ---| ---| ---|
| ![Landing](./readme/demo/landing.png) | ![Login](./readme/demo/Login.png) | ![Home](./readme/demo/home.png) |
| Product screen  | Map screen  | Home Screen |
| ![Product](./readme/demo/product.png) | ![Map](./readme/demo/map.png) | ![Scan](./readme/demo/scan.png) |
| Chat Screen |
| ![Chat](./readme/demo/chat.png) |

<br><br>

<!-- Implementation -->
<img src="./readme/title4.svg"/>

> Using the wireframes and mockups as a guide, we implemented the Floravert app with the following features:

### User Screens
| Login screen  | Scan screen | Map screen | Chat screen |
| ---| ---| ---| ---|
| ![Login](./readme/login.gif) | ![Scan](./readme/scan-1.gif) | ![Map](./readme/map.gif) | ![Chat](./readme/product.gif) |
| Register screen  | Setup Screen | Market Screen | Profile Screen |
| ![Register](./readme/signup.gif) | ![Setup](./readme//setup.gif) | ![Market](./readme/market.gif) | ![Profile](./readme/profile.gif) |


<br><br>

<img src="./readme/plant_net_open_ai.svg">

> Floravert makes use of open access to 3rd party apis to fulfill its mission: "Be there to help users identify any plant they want, from a single image". To acheive this mission, we had to use two separate and indeed powerful apis: Plant Net's API for plant identification, and OpenAI's API for text generation. Before we go into details on how it's done, let's first introduce PlantNet and OpenAI.

### PlantNet
- PlantNet is a renowned organization committed to plant identification and conservation. Their mission is to create a global network of individuals and experts who collaborate to identify and document plant species through a mobile application. By harnessing the power of crowdsourcing and artificial intelligence, PlantNet aims to increase botanical knowledge, promote biodiversity conservation, and facilitate ecological research for the benefit of both scientific communities and the general public.
### OpenAI:
- OpenAI is a leading artificial intelligence research organization focused on developing advanced AI technologies. They are known for creating powerful language models like GPT-3, which can understand and generate human-like text. OpenAI aims to promote the responsible and ethical use of AI while advancing the boundaries of what AI systems can accomplish.

### Connecting the Pieces:
> PlantNet's Model is able to identify plants with amazing accuracy, and it returns a rich collection of data to work with. The returned response looks something like this:

```JSON
{
"query": {
"project": "best",
"images": [
"buffer_code_image_1",
"buffer_code_image_2"
],
"organs": [
"flower",
"leaf"
]
},
"language": "en",
"preferedReferential": "useful",
"results": [
{
"score": 0.9952006530761719,
"species": {
	"scientificNameWithoutAuthor": "Hibiscus rosa-sinensis",
	"scientificNameAuthorship": "L.",
	"genus": {
		"scientificNameWithoutAuthor": "Hibiscus",
		"scientificNameAuthorship": "L."
	},
	"family": {
		"scientificNameWithoutAuthor": "Malvaceae",
		"scientificNameAuthorship": "Juss."
	},
	"commonNames": [
		"Chinese hibiscus",
		"Hawaiian hibiscus",
		"Hibiscus"
	]
}
}
],
"remainingIdentificationRequests": 1228
}
```
> We can see that we have plenty of details already, and most importantly we notice that the result of our scan is a results array, each having a score. We'll discuss the score later on, but for now, let's discuss which pieces of the results are required for our use case.

```JSON
"species": {
	"scientificNameWithoutAuthor": "Hibiscus rosa-sinensis", //here
	"scientificNameAuthorship": "L.",
	"genus": {
		"scientificNameWithoutAuthor": "Hibiscus",
		"scientificNameAuthorship": "L."
	},
	"family": {
		"scientificNameWithoutAuthor": "Malvaceae",
		"scientificNameAuthorship": "Juss."
	},
	"commonNames": [
		"Chinese hibiscus", //here
		"Hawaiian hibiscus",
		"Hibiscus"
	]
}

```
> We are only interested in the common name of the plant as well as its scientific name, which are going to be sent in a prompt to one of OpenAI's Models in order to generate the required description. But before we skip to the next step, let's discuss the score. The score here represents the confidence level assigned to a given prediction, think of it as the degree to which the model is confident that its response is correct, and from that we deduce that a score closer to 1 implies a more reliable result (but take that with a grain of salt). It is also worthy to note that PlantNet's API returns the results in decreasing order and thus the best match is always the first element in the array and based on that Floravert takes only the first element in the array to feed to OpenAI's Model.

### The Prompt
> Plenty of consideration was taken into designing the prompt which was to be fed to OpenAI's model, it had to be accurate and retieve only the required data. It also had to be brief and straight to the point to optimize the costs of calling the api. After extensive testing, we found that this prompt fit our needs the best:

```js
`generate only a JSON Parsable Object for a plant called "${commonName}", with scientific name "${botanicalName}
    " and fill, with real accurate data, the following:
    Follow this structure:
    {
        "commonName": ${commonName},
        "botanicalName": ${botanicalName},
        "description": insert generated description here
        "keyFacts": {
            "seasonality": one word only
            "edibility": one word only
            "habitat": one word only
            "toxicity": one word only
            "use": one word only
            "status": one word only 
        },
        "recipes": [
            {
                "name": insert name here,
                "ingredients": insert ingredients here
            }
        ],
        "benefits": [
            "insert only 3 benefits here"
        ],
        "commonUses": [
            "insert only 3 common uses here"
        ],
        "regions": [
            "insert regions here -- by one word name"
        ]
    }
    
    `
```
> So far this prompt hasn't failed even once to get the data correctly and accurately as expected. Now let's see an example of the response before we conclude this section.

```JSON
{
    "data": {
        "image": "", //link to image storage location
        "result": {
            "commonName": "Rosemary",
            "botanicalName": "Rosmarinus officinalis",
            "description": "Rosemary is an evergreen shrub with fragrant, needle-like leaves and small, pale blue flowers. It is native to the Mediterranean region and is a popular culinary herb.",
            "keyFacts": {
                "seasonality": "Perennial",
                "edibility": "Edible",
                "habitat": "Mediterranean",
                "toxicity": "Non-toxic",
                "use": "Herbal",
                "status": "Cultivated"
            },
            "recipes": [
                {
                    "name": "Rosemary Roasted Potatoes",
                    "ingredients": "Potatoes, olive oil, rosemary, garlic, salt, pepper"
                }
            ],
            "benefits": [
                "Improves digestion",
                "Boosts immune system",
                "Reduces inflammation"
            ],
            "commonUses": [
                "Cooking",
                "Aromatherapy",
                "Medicinal"
            ],
            "regions": [
                "Europe",
                "Asia",
                "Africa"
            ]
        }
    }
}
```

<br><br>

<!-- Tech stack -->
<img src="./readme/title5.svg"/>

###  Floravert is built using the following technologies:

- This project uses the [Flutter app development framework](https://flutter.dev/). Flutter is a cross-platform hybrid app development platform which allows us to use a single codebase for apps on mobile, desktop, and the web.
- For persistent storage (database), the app uses the [Mongoose](https://mongoosejs.com/) package which allows the app to create a custom storage schema and save it to a MongoDB database.
- To send local push notifications, the app uses the [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) package which supports Android, iOS, and macOS.

<br><br>

<!-- How to run -->
<img src="./readme/title6.svg"/>

> To set up Floravert locally, follow these steps:

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ```

Now, you should be able to run Coffee Express locally and explore its features.