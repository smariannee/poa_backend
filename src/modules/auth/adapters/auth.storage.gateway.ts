/**
 * @interface AuthStorageGateway
 * @description request to the database
 */
import {AuthRepository} from "@/modules/auth/use-cases/ports/auth.repository";
import {LoginUserDto, RecoverPwdUserDto} from "@/modules/auth/entities";
import {User} from "@/modules/auth/boundary";
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


    insertResetToken(user: RecoverPwdUserDto): Promise<boolean> {
        throw new Error('Not Implemented yet')
    }

    findByTokenReset(token: string): Promise<number> {
        throw new Error('Not Implemented yet')
    }

    recoverPassword(user: RecoverPwdUserDto): Promise<User> {
        throw new Error('Not Implemented yet')
    }

}
