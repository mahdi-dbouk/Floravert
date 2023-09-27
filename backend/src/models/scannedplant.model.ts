import mongoose from 'mongoose';
const {model, Schema} = mongoose;

const scannedPlantSchema = new Schema({
    image: {type: String, required: true},
    commonName: {type: String, required: true},
    botanicalName: {type: String, required: true},
    description: {type: String, required: true},
    keyFacts:{
        edibility: {type: String, required: false},
        seasonality: {type: String, required: false},
        toxicity: {type: String, required: false},
        habitat: {type: String, required: false},
        usecase: {type: String, required: false},
        status: {type: String, required: false},
    },

    benefits : [{type:String, required: false}],

    commonUses: [{type:String, required: false}],

    recipes: [{
        name: {type: String, required: true},
        ingredients: [{type: String, required: true}],
        category: {type: String, required: true} 
    }],
    regions: [{ type: String, required: false }],
});

const ScannedPlant = model('ScannedPlant', scannedPlantSchema);

export {
    ScannedPlant,
    scannedPlantSchema
}