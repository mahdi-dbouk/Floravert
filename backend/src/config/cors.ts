import { CorsOptions } from "cors";

const allowedOrigins: string[] = [
    '*',
];
const options: CorsOptions = {
    origin: allowedOrigins
};

export default options;