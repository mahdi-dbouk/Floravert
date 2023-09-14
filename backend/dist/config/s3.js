import S3 from "aws-sdk/clients/s3.js";
import 'dotenv/config';
import { PassThrough } from "stream";
const bucketName = process.env.S3_BUCKET_NAME;
const region = process.env.S3_BUCKET_REGION;
const secretAccessKey = process.env.AWS_SECRET_KEY;
const accessKeyId = process.env.AWS_ACCESS_KEY;
const s3 = new S3({
    region,
    accessKeyId,
    secretAccessKey
});
export const uploadToS3 = (buffer, key) => {
    const passThrough = new PassThrough();
    const uploadParams = {
        Bucket: bucketName,
        Body: passThrough,
        Key: key
    };
    passThrough.end(buffer);
    return s3.upload(uploadParams, (error) => {
        if (error)
            console.log(error);
    }).promise();
};
//# sourceMappingURL=s3.js.map