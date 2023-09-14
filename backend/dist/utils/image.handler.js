import { uploadToS3 } from "../config/s3.js";
export const decodeThenSendToS3 = async (base64Image) => {
    let [format, base64ImageData] = base64Image.split(';base64,');
    format = format.split('/').pop();
    console.log(format);
    const filename = `image_${Date.now()}.${format}`;
    const imageBuffer = Buffer.from(base64ImageData, 'base64');
    const result = await uploadToS3(imageBuffer, filename);
    console.log(result);
    return result;
};
//# sourceMappingURL=image.handler.js.map