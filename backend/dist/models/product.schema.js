import mongoose from 'mongoose';
const { model, Schema } = mongoose;
const productSchema = new Schema({
    name: { type: String, required: true },
    traderId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    category: { type: String, required: true },
    ratings: [{ type: Number, required: false }],
    images: [{ type: String, required: false }],
    description: { type: String, required: true },
    totalQuantity: { type: String, required: true }
});
export default productSchema;
//# sourceMappingURL=product.schema.js.map