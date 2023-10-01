import {Response} from 'express';
import { AuthRequest } from '../middlewares/auth.middleware.js';
import User from '../models/user.model.js';

let connectedUsers = [];

export const chatsHandler = (io) => {
    io.on('connection', (socket)=>{
        console.log(`user: ${socket.id}`);
        console.log(socket.handshake.auth.email);
        socket.on("test", (args) => {
            console.log(args);
        });

        socket.emit('authRequest', {message: "authentication required"});
        socket.on('authResponse', (data)=>{
            const existingUser = connectedUsers.find((user) => user.email === data.email);
            if (!existingUser) {
                connectedUsers.push({ email: data.email, id: socket.id });
            }
            socket.userId = data.email;
            console.log(connectedUsers);
        });
        

        socket.emit('authSuccess', {message: `Auth is successful`});

        socket.on('send_message', (data) => {
            console.log(data);

        const user = connectedUsers.find((user) => user.email === data.to);
        console.log(user);
        if(user !== undefined){
            io.to(user.id).emit('received_message', {id:socket.id, content: data.content});
        }
        else{
            console.log('here');
            io.to(socket.id).emit('error', {error: "user not here.."});
        }
        });
    
        socket.on('disconnect', () => {
            connectedUsers = connectedUsers.filter(obj => obj.id !== socket.id);
            console.log(`${socket.id} disconnected`)
        })
    });
}



export const createContact = async (req: AuthRequest, res: Response) => {
    const _id = req.user._id;
    const {userId} = req.body;

    try {
        //save contact to database
        const user = await User.findByIdAndUpdate(
            {_id},
            {$push: {
                contacts: { user: {_id: userId}}
            }},
            {new: true}
        );

        return res.status(201).json({
            message: "Contact Created",
            user
        });
        
    } catch (error) {
        return res.status(500).json({
            erro: error
        });
    }
}

export const createMessage = async (req: AuthRequest, res: Response) => {
    const _id = req.user._id;
    const {receiverId, content} = req.body;

    try {
        const user = await User.findOneAndUpdate(
            {_id},
            {$push: {
                messages: {
                    sender: _id,
                    receiver: receiverId,
                    content: content,
                }
            }},
            {new: true}
        );

        return res.status(201).json({
            message: "Message Sent",
            user
        });


    } catch (error) {
        return res.status(500).json({
            erro: error
        });
    }



}

export const getChatHistory = async (req: AuthRequest, res:Response) => {

}

export const deleteChat = async (req: AuthRequest, res: Response) => {
    
}
export const deleteContact = async (req: AuthRequest, res: Response) => {
    
}


