import { Router } from "express";
import { addLike, getAllPosts } from "../controllers/post.controller.js";
import { isAuthorized } from "../middlewares/auth.middleware.js";
let router = Router();
router.get("/", (req, res) => {
    return res.status(200).json({
        success: true,
        testMessage: "test successful from post routes",
    });
});
router.get("/all", isAuthorized, getAllPosts);
router.post("/like", isAuthorized, addLike);
export default router;
//# sourceMappingURL=post.routes.js.map