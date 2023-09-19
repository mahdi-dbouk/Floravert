import User from "../models/user.model.js";
import { processImages } from "../utils/image.handler.js";
export const createProduct = async (req, res) => {
    const _id = req.user._id;
    const { name, category, images, description, totalQuantity } = req.body;
    const imageUrls = await processImages(images, res);
    try {
        const updatedUser = await User.findByIdAndUpdate(_id, {
            $push: {
                products: {
                    name,
                    category,
                    description,
                    images: imageUrls,
                    totalQuantity
                }
            }
        }, { new: true });
        if (updatedUser) {
            return res.status(200).json({
                message: "added successfully",
                user: updatedUser,
            });
        }
    }
    catch (error) {
        return res.status(500).json({
            error: error
        });
    }
};
//# sourceMappingURL=product.controller.js.map