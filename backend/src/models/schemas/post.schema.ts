import mongoose from "mongoose";
const { Schema } = mongoose;

const commentSchema = new Schema({
  user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    content: { type: String, required: true },
    replies: [{
        user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
        content: { type: String, required: true },
    }],
}, {timestamps: true});

const postSchema = new Schema({
  content: { type: String, required: true },
  likes: { type: Number, default: 0 },
  comments: [commentSchema],
}, {timestamps: true});


export default postSchema;