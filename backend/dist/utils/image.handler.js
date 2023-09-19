import { uploadToS3 } from "../config/s3.js";
export const decodeThenSendToS3 = async (base64Image) => {
    let [format, base64ImageData] = base64Image.split(';base64,');
    const contentType = format.split(':')[1];
    format = format.split('/').pop();
    console.log(format);
    const filename = `image_${Date.now()}.${format}`;
    const imageBuffer = Buffer.from(base64ImageData, 'base64');
    const result = await uploadToS3(imageBuffer, filename, contentType);
    console.log(result);
    return result;
};
export const processImages = async (base64Images, res) => {
    try {
        const promises = base64Images.map(async (base64Image) => {
            const awsResponse = await decodeThenSendToS3(base64Image);
            return awsResponse.Location;
        });
        const imageUrls = await Promise.all(promises);
        console.log(imageUrls.length, "number of images");
        return imageUrls;
    }
    catch (error) {
        console.error('Error processing images:', error);
        return res.status(500).json({
            error: 'An error occurred while processing images'
        });
    }
};
//# sourceMappingURL=image.handler.js.map