import jwt from 'jsonwebtoken';
import env from 'dotenv';
import * as process from 'process';
import bcryptjs from 'bcryptjs';

/**
 * Load environment variables
 */
env.config();

/**
 * @description Handle Token and encrypt data
 */
export const generateToken = (payload: object) => {
    // token time 12hrs
    return jwt.sign(payload, process.env.SECRET_KEY || 'poax', {
        expiresIn: 60 * 60 * 12
    });
}

export const decodeToken = (token: string) => {
    return jwt.verify(token, process.env.SECRET_KEY || 'poax')
}

export const encodeString = async (data: string): Promise<string> => {
    const salt = await bcryptjs.genSalt(10);
    return bcryptjs.hash(data, salt);
}

export const compareEncrypt = async (data: string, dataEncrypt: string): Promise<boolean> => {
    return await bcryptjs.compare(data, dataEncrypt);
}

export const  generateRandomString = ():string => {
    let result = '';
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWYZ1234567890';

    for (let i = 0; i < 15; i++)
        result += characters.charAt(Math.floor(Math.random() *characters.length));

    return result;
}