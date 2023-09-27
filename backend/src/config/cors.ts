import { CorsOptions } from "cors";

const allowedOrigins: string[] = [
    'http://localhost:8000',
    'http://192.168.0.103:8000',
    'http://localhost:3000',
    '*',
];
const options: CorsOptions = {
    origin: allowedOrigins
};

export default options;