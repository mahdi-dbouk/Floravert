import mongoose from "mongoose";
import 'dotenv/config';

const env = process.env;

const uri : string = `mongodb://127.0.0.1:${env.DB_PORT}/${env.DB_NAME}`;

const mongoDBConn = async () => {
    try {
        await mongoose.connect(uri);
        console.log("Connected to MongoDB");
    } catch (error) {
        console.log(error);
    }
};

export default mongoDBConn;


