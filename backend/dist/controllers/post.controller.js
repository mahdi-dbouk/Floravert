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
//# sourceMappingURL=post.controller.js.map