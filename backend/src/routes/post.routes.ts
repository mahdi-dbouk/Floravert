import { Router, Request, Response } from "express";
import { getAllPosts } from "../controllers/post.controller.js";
import { isAuthorized } from "../middlewares/auth.middleware.js";
let router : Router = Router();

router.get("/", (req : Request, res : Response) => {
    return res.status(200).json({
        success: true,
        testMessage: "test successful from post routes",
    });
});

router.get("/all", isAuthorized, getAllPosts);

export default router;