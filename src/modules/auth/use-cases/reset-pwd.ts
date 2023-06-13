import {UseCase} from "@/kernel/contracts";
import {ResetPwdUserDto} from "@/modules/auth/entities";
import {User} from "@/modules/auth/boundary";
import {AuthRepository} from "@/modules/auth/use-cases/ports/auth.repository";

export class ResetPwd implements UseCase<ResetPwdUserDto, User> {
    constructor(private readonly authRepository: AuthRepository) {
    }

    async execute(payload: ResetPwdUserDto): Promise<User> {
        const {newPassword, token} = payload;
        if (!newPassword || !token) throw Error('Missing fields');
        const resp =  await this.authRepository.findByResetToken(token);
        if (!resp) throw Error('Not found');

        return this.authRepository.resetPassword({
            id: resp,
            newPassword: newPassword
        } as ResetPwdUserDto);
    }
}