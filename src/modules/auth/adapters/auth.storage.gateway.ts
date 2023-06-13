/**
 * @interface AuthStorageGateway
 * @description request to the database
 */
import {AuthRepository} from "../use-cases/ports/auth.repository";
import {LoginUserDto, ResetPwdUserDto} from "@/modules/auth/entities";
import {User} from "../boundary";
import {pool} from "../../../utils/dbconfig";

export class AuthStorageGateway implements AuthRepository {

    async login(user: LoginUserDto): Promise<User> {
        try {
            const {email} = user;
            const response = await pool.query('SELECT * FROM  users WHERE email = $1 ', [email]);
            return response.rows[0] as User;
        } catch (e) {
            console.error(e);
            throw Error('Server Error');
        }
    }


    async generateResetToken(user: ResetPwdUserDto): Promise<boolean> {
        try {
            const {id, token} = user;
            const response = await pool.query(
                'UPDATE users SET "reset_token" = $1 WHERE id = $2',[token, id]
            );
            return response.rows[0] > 0;
        } catch (error) {
            throw Error('Server Error');
        }
    }

    findByResetToken(token: string): Promise<number> {
        throw new Error('Not Implemented yet')
    }

    resetPassword(user: ResetPwdUserDto): Promise<User> {
        throw new Error('Not Implemented yet')
    }

}
