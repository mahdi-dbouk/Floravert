import { Router, Request, Response } from "express";
import { addLike, getAllPosts, addComment, addReply} from "../controllers/post.controller.js";
import { isAuthorized } from "../middlewares/auth.middleware.js";
let router : Router = Router();

router.get("/", (req : Request, res : Response) => {
    return res.status(200).json({
        success: true,
        testMessage: "test successful from post routes",
    });
});

router.get("/all", isAuthorized, getAllPosts);
router.post("/like", isAuthorized, addLike);
router.post("/comment", isAuthorized, addComment);
router.post("/reply", isAuthorized, addReply);

export default router;