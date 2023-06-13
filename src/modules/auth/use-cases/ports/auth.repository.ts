
import {User} from "../../boundary";
import {LoginUserDto, RecoverPwdUserDto} from "@/modules/auth/entities";

//actions that the use case can perform
export interface AuthRepository {
    login(user: LoginUserDto): Promise<User>;
    insertResetToken(user: RecoverPwdUserDto): Promise<boolean>;
    findByTokenReset(token: string): Promise<number>;
    recoverPassword(user: RecoverPwdUserDto): Promise<User>;
}