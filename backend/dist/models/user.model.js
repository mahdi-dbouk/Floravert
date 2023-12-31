import mongoose from "mongoose";
import { scannedPlantSchema } from "./scannedplant.model.js";
import postSchema from "./schemas/post.schema.js";
import messageSchema from "./schemas/message.schema.js";
import contactSchema from "./schemas/contact.schema.js";
import productSchema from "./schemas/product.schema.js";
const { model, Schema } = mongoose;
const userSchema = new Schema({
    firstName: { type: String, required: true },
    lastName: { type: String, required: true },
    email: { type: String, required: true },
    hashedPassword: { type: String, required: true },
    age: { type: Number, required: true },
    phone: { type: String, required: true },
    picture_url: { type: String, required: false },
    isTrader: { type: Boolean, required: false },
    posts: [postSchema],
    scannedPlants: [scannedPlantSchema],
    products: [productSchema],
    messages: [messageSchema],
    followers: [{ type: Schema.Types.ObjectId, ref: 'User', required: false }],
    followed: [{ type: Schema.Types.ObjectId, ref: 'User', required: false }],
    contacts: [contactSchema]
});
const User = model('User', userSchema);
export default User;
//# sourceMappingURL=user.model.js.map