import express, { Application } from "express";
import 'dotenv/config';
import mongoDBConn from "./config/connection.js";
import cors from 'cors';
import options from "./config/cors.js";

const PORT : String|Number = process.env.PORT || 8000;

const app : Application = express();

app.use(cors(options));

app.use(express.json());

app.listen(PORT, () => {
    console.log(`Server is listening on port ${PORT}`);
    console.log(`http://localhost:${PORT}`);
});

mongoDBConn();