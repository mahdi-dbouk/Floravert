import {openai} from '../config/openai.js';
import { ScanedRequest } from '../middlewares/api.middleware.js';
import {Response} from 'express';

const createCustomPrompt = (commonName:string, botanicalName: string) => {
    return `generate only a JSON Parsable Object for a plant called "${commonName}", with scientific name "${botanicalName}
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
    
    `;
}

export const getPlantData = async (req: ScanedRequest, res: Response) => {
    const {commonName, botanicalName, imageURL} = req.plant;
    let response = null;
    let result = '';

    try {
        response = await openai.completions.create({
            model: 'text-davinci-003',
            prompt: createCustomPrompt(commonName, botanicalName),
            max_tokens: 500,
            temperature: 0,
        });
    
        result = response.choices[0].text.replace(/\\/g, '').replace(/\n/g, '');
        result = result.replace(/\s+/g, " ").replace(/\\"/g, '"');
        result = result.replace(/\\/g, "");
        result = JSON.parse(result);
        console.log(result);
    } catch (error) {
        return res.status(500).json({
            error: error
        });
    }

    return res.status(200).json({
        data: {
            image: imageURL,
            result
        }
    });
    
}



