import User from '../models/user.model.js';
export const getAllPosts = async (req, res) => {
    const users = await User.find({}, 'posts');
    try {
        const allPosts = users.flatMap(user => user.posts);
        return res.status(200).json({
            data: allPosts
        });
    }
    catch (error) {
        return res.status(500).json({
            error: error
        });
    }
};
export const addLike = async (req, res) => {
    const { postId, userId } = req.body;
    try {
        const user = await User.findOneAndUpdate({ _id: userId, 'posts._id': postId }, { $inc: { 'posts.$.likes': 1 } }, { new: true });
        return res.status(200).json({
            message: "like added"
        });
    }
    catch (error) {
        return res.status(500).json({
            error: error
        });
    }
};
export const addComment = async (req, res) => {
    const { postId, userId, content } = req.body;
    try {
        const user = await User.findOneAndUpdate({ _id: userId, 'posts._id': postId }, { $push: { "posts.$.comments": {
                    user: req.user._id,
                    content
                } } }, { new: true });
        return res.status(200).json({
            message: "comment added"
        });
    }
    catch (error) {
        return res.status(500).json({
            error: error
        });
    }
};
export const addReply = async (req, res) => {
    const { postId, userId, commentId, content } = req.body;
    try {
        const user = await User.findOneAndUpdate({ _id: userId, 'posts._id': postId, "posts.comments._id": commentId }, { $push: { "posts.$[outer].comments.$[inner].replies": {
                    user: req.user._id,
                    content
                } } }, {
            new: true,
            arrayFilters: [
                { "outer._id": postId },
                { "inner._id": commentId }
            ]
        });
        return res.status(200).json({
            message: "reply added"
        });
    }
    catch (error) {
        return res.status(500).json({
            error: error
        });
    }
};
//# sourceMappingURL=post.controller.js.map