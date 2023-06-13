import { UseCase } from "@/kernel/contracts";
import { UpdatePasswordUserDto } from "../adapters/dto/UpdatePasswordUserDto";
import { User } from "../entities/user";
import { UserRepository } from "./ports/user.repository";
import { compareEncrypt, encodeString } from "../../../kernel/jwt";
import { validatePassword } from "../../../utils/validations";

export class UpdatePasswordUserInteractor implements UseCase<UpdatePasswordUserDto, User> {
    constructor(private readonly userRepository: UserRepository) {}
    async execute(payload: UpdatePasswordUserDto): Promise<User> {
        if (!payload.id) throw Error('Missing id')
        if (isNaN(payload.id)) throw Error('Invalid id')
        if (!payload.old_password || !payload.new_password) throw Error('Missing fields')
        if (!validatePassword(payload.new_password)) throw Error('Invalid password')
        if (await this.userRepository.existsById(payload.id)) {
            const user = await this.userRepository.findById(payload.id)
            if (!await compareEncrypt(payload.old_password, user.password! )) throw Error('Incorrect credentials')
        } else {
            throw Error('Not found')
        }
        payload.new_password = await encodeString(payload.new_password)
        return this.userRepository.updatePassword(payload);
    }
}