import {UseCase} from "@/kernel/contracts";
import {LoginUserDto} from "@/modules/auth/entities";
import {User} from "@/modules/auth/boundary";
import {AuthRepository} from "@/modules/auth/use-cases/ports/auth.repository";
import {compareEncrypt} from "../../../kernel/jwt";

/**
 * @class AuthLoginInteractor
 * @description Use case for login user in the system
 * i have question can we do this in another way to don't ask the user to th db with only email;
 */

export class AuthLoginInteractor implements UseCase<LoginUserDto, User>{

    constructor(private readonly authRepository: AuthRepository) {
    }

    async execute(payload: LoginUserDto): Promise<User> {
        if (!payload.email || !payload.password) throw Error('Missing fields');
        const user: User = await this.authRepository.login(payload);
        if (!user) throw Error('Incorrect credentials');
        if (!await compareEncrypt(payload.password, user.password! )) throw Error('Incorrect credentials');
        return user;
    }
}