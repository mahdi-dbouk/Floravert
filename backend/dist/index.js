import express from 'express';
import 'dotenv/config';
import mongoDBConn from './config/connection.js';
import cors from 'cors';
import options from "./config/cors.js";
import userRoutes from './routes/user.routes.js';
import postRoutes from './routes/post.routes.js';
import * as SocketIO from 'socket.io';
import * as http from 'http';
import { chatsHandler } from './controllers/chat.controller.js';
const PORT = process.env.PORT || 8000;
const app = express();
app.use(cors(options));
const server = http.createServer(app);
const io = new SocketIO.Server(server, {
    cors: {
        origin: "http://localhost:3000",
        methods: ['*']
    }
});
chatsHandler(io);
app.use(express.json({ limit: '50mb' }));
server.listen(PORT, () => {
    console.log(`Server is listening on port ${PORT}`);
    console.log(`http://localhost:${PORT}`);
});
mongoDBConn();
app.use('/user', userRoutes);
app.use('/posts', postRoutes);
//# sourceMappingURL=index.js.map