import { Router, Request, Response } from "express";
import {login} from '../controllers/auth.controller.js';
import {isAuthorized} from '../middlewares/auth.middleware.js';
let router : Router = Router();

router.post("/login", login);

export default router;