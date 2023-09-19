import express from "express";
import 'dotenv/config';
import mongoDBConn from "./config/connection.js";
import cors from 'cors';
import options from "./config/cors.js";
import userRoutes from './routes/user.routes.js';
import postRoutes from './routes/post.routes.js';
const PORT = process.env.PORT || 8000;
const app = express();
app.use(cors(options));
app.use(express.json({ limit: '50mb' }));
app.listen(PORT, () => {
    console.log(`Server is listening on port ${PORT}`);
    console.log(`http://localhost:${PORT}`);
});
mongoDBConn();
app.use('/user', userRoutes);
app.use('/posts', postRoutes);
//# sourceMappingURL=index.js.map