import { AuthRequest } from "../middlewares/auth.middleware.js";
import { Response } from "express";
import User from "../models/user.model.js";
import { processImages } from "../utils/image.handler.js";

export const createProduct = async (req: AuthRequest, res: Response) => {
    const _id = req.user._id;
    const {name, category, images, price, description, totalQuantity} = req.body;


    const imageUrls = await processImages(images, res);

    try {
        const updatedUser = await User.findByIdAndUpdate(_id, {
            $push: {
                products: {
                    name,
                    category,
                    description,
                    price,
                    images: imageUrls,
                    totalQuantity
                }
            }
        },
        {new: true}
        );

        if(updatedUser){
            return res.status(200).json({
                message: "added successfully",
                user: updatedUser,
            });
        }
    } catch (error) {
        return res.status(500).json({
            error: error
        });
    }
}

export const getAllProducts = async (req: AuthRequest, res: Response) => {
    const users = await User.find();
    console.log(users)

    const allProducts = [];


    try {
        for (const user of users) {
          for (const product of user.products) {
            const productWithTrader = {
              traderName: `${user.firstName} ${user.lastName}`,
              email: user.email,
              phone: user.phone,
              traderId: user._id,
              traderProfilePic: user.picture_url,
              product
            };
    
            allProducts.push(productWithTrader);
          }
        }
        
        return res.status(200).json({
            data: allProducts
        });
    } catch (error) {
        return res.status(500).json({
            error: error
        });
    }

}

export const deleteProduct = async (req: AuthRequest, res: Response) => {
    const _id = req.user._id;
    const {productId} = req.body;

    try {
        const updatedUser = await User.findOneAndUpdate({_id},
            {
                $pull: {
                    products: {_id: productId}
                },
            },
            {new: true}
        );

        return res.status(200).json({
            message: "Product deleted successfully",
            user: updatedUser
        });

    } catch (error) {
        return res.status(500).json({
            message: "failed to delete",
            error: error
        });
    }
}

export const updateProduct = async (req: AuthRequest, res: Response) => {
    const _id = req.user._id;
    const {productId, name, category, description, totalQuantity} = req.body;

    try {

        const updatedProduct = await User.findOneAndUpdate(
            {_id, 'products._id': productId},
            {
                $set: {
                    'products.$.name': name,
                    'products.$.category': category,
                    'products.$.description': description,
                    'products.$.totalQuantity': totalQuantity,

                }
            },
            {new: true}
        );

        return res.status(200).json({
            message: "updated successfully",
            product: updatedProduct
        });
        
    } catch (error) {
        return res.status(500).json({
            message: "failed to update",
            error: error
        });
    }
}

