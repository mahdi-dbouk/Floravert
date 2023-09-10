import express, { Express, Request, Response, NextFunction } from "express";
import 'dotenv/config';

const PORT : String|Number = process.env.PORT || 8000;

const app : Express = express();

app.get('/', (req:Request, res:Response)=>{
    return res.json({
        message: "testing",
    });
});

app.listen(PORT, () => {
    console.log(`Server is listening on port ${PORT}`);
    console.log(`http://localhost:${PORT}`);
});