import { Router } from "express";
import { login } from '../controllers/auth.controller.js';
import { isAuthorized } from '../middlewares/auth.middleware.js';
let router = Router();
router.post("/login", isAuthorized, login);
export default router;
//# sourceMappingURL=user.routes.js.map