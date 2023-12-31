import express, { Application } from 'express';
import 'dotenv/config';
import mongoDBConn from './config/connection.js';
import cors from 'cors';
import options from "./config/cors.js";
import userRoutes from './routes/user.routes.js';
import postRoutes from './routes/post.routes.js';
import * as SocketIO from 'socket.io';
import * as http from 'http';
import { chatsHandler } from './controllers/chat.controller.js';


const PORT : String|Number = process.env.PORT || 8000;
const HOST_ADDRESS : String = process.env.HOST_ADDRESS;

const app : Application = express();


app.use(cors(options));
const server: http.Server = http.createServer(app);

const io = new SocketIO.Server(server, {
    cors: {
        origin: "*",
        methods: ['*']
    }
});

chatsHandler(io);

app.use(express.json({limit: '50mb'}));

server.listen({port:PORT, host: HOST_ADDRESS}, () => {
    console.log(`Server is listening on port ${PORT}`);
    console.log(`http://${HOST_ADDRESS}:${PORT}`);
});

mongoDBConn();

app.use('/user',userRoutes);
app.use('/posts', postRoutes);
