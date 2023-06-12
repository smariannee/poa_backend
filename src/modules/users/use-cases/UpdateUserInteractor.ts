import { UseCase } from "../../../kernel/contracts";
import { UpdateUserDto } from "../adapters/dto";
import { Role } from "../entities/role";
import { User } from "../entities/user";
import { UserRepository } from "./ports/user.repository";
import { validateEmail, validateExtensionNumber, validatePassword, validatePhoneNumber } from "../../../utils/validations"

export class UpdateUserInteractor implements UseCase<UpdateUserDto, User> {
    constructor(private readonly userRepository: UserRepository) {}
    async execute(payload: UpdateUserDto): Promise<User> {
        if (!payload) throw Error('Missing fields')
        if (!validateEmail(payload.email)) throw Error('Invalid email')
        if (payload.phone_number && !validatePhoneNumber(payload.phone_number)) throw Error('Invalid phone number')
        if (payload.extension_number && !validateExtensionNumber(payload.extension_number)) throw Error('Invalid extension number')
        const role: Role = payload['role'] as Role
        if (!Role[role]) throw Error('Invalid role')
        if (!await this.userRepository.existsById(payload.id)) throw Error('Not found')
        return this.userRepository.update(payload)
    }
}