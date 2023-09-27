import User from '../models/user.model.js';
export const chatsHandler = (io) => {
    io.on('connection', (socket) => {
        console.log(`user: ${socket.id}`);
        socket.on("test", (args) => {
            console.log(args);
        });
        socket.on('disconnect', () => {
            console.log(`${socket.id} disconnected`);
        });
    });
};
export const createContact = async (req, res) => {
    const _id = req.user._id;
    const { userId } = req.body;
    try {
        //save contact to database
        const user = await User.findByIdAndUpdate({ _id }, { $push: {
                contacts: { user: { _id: userId } }
            } }, { new: true });
        return res.status(201).json({
            message: "Contact Created",
            user
        });
    }
    catch (error) {
        return res.status(500).json({
            erro: error
        });
    }
};
export const createMessage = async (req, res) => {
    const _id = req.user._id;
};
export const getAllMessages = async (req, res) => {
};
export const deleteChat = async (req, res) => {
};
export const deleteContact = async (req, res) => {
};
//# sourceMappingURL=chat.controller.js.map