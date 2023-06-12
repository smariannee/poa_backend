import { ResponseApi } from "../kernel/types";

const errors: {[x: string]: ResponseApi<undefined>} = {
    'Missing fields': { code: 400, error: true, message: 'Missing fields' },
    'Invalid id': { code: 400, error: true, message: 'Invalid id' },
    'Invalid email': { code: 400, error: true, message: 'Invalid email' },
    'Invalid password': { code: 400, error: true, message: 'Invalid password' },
    'Invalid phone number': { code: 400, error: true, message: 'Invalid phone number' },
    'Invalid extension number': { code: 400, error: true, message: 'Invalid extension number' },
    'Invalid role': { code: 400, error: true, message: 'Invalid role' },
    'Already exists': { code: 400, error: true, message: 'Already exists' },
    'Not found': { code: 404, error: true, message: 'Not found' },
    'Bad Request': { code: 400, error: true, message: 'Bad Request' },
    'Server Error': { code: 500, error: true, message: 'Internal Server Error' },
};

export const validateError = (error: Error): ResponseApi<undefined> => {
    return errors[error.message];
}