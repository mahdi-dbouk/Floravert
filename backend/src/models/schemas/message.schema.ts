import mongoose from 'mongoose';
const {Schema} = mongoose;

const messageSchema = new Schema({
  sender: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  content: { type: String, required: true },
}, {timestamps: true});

export default messageSchema;