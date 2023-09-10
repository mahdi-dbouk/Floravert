import express from "express";
import 'dotenv/config';
const PORT = process.env.PORT || 8000;
const app = express();
app.get('/', (req, res) => {
    return res.json({
        message: "testing",
    });
});
app.listen(PORT, () => {
    console.log(`Server is listening on port ${PORT}`);
    console.log(`http://localhost:${PORT}`);
});
//# sourceMappingURL=index.js.map