import mongoose from "mongoose";
const { Schema } = mongoose;
const contactSchema = new Schema({
    user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    lastSeen: { type: Date, required: true },
    blocked: { type: Boolean, required: true }
}, { timestamps: true });
export default contactSchema;
//# sourceMappingURL=contact.schema.js.map