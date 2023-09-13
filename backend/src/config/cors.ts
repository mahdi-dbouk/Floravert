import { CorsOptions } from "cors";

const allowedOrigins: string[] = [
    'http://localhost:8000',
    'null',
];
const options: CorsOptions = {
    origin: allowedOrigins
};

export default options;