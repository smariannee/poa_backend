
import {User} from "../../boundary";
import {LoginUserDto, ResetPwdUserDto} from "@/modules/auth/entities";

//actions that the use case can perform
export interface AuthRepository {
    login(user: LoginUserDto): Promise<User>;
    generateResetToken(user: ResetPwdUserDto): Promise<boolean>;
    findByResetToken(token: string): Promise<number>;
    resetPassword(user: ResetPwdUserDto): Promise<User>;
}