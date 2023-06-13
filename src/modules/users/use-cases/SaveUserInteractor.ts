import { UseCase } from "../../../kernel/contracts"
import { encodeString } from "../../../kernel/jwt"
import { createPassword } from "../../../utils/functions"
import { validateEmail, validateExtensionNumber, validatePassword, validatePhoneNumber } from "../../../utils/validations"
import { SaveUserDto } from "../adapters/dto"
import { Role } from "../entities/role"
import { User } from "../entities/user"
import { UserRepository } from "./ports/user.repository"

export class SaveUserInteractor implements UseCase<SaveUserDto, User> {
    constructor(private readonly userRepository: UserRepository) {}
    async execute(payload: SaveUserDto): Promise<User> {
        const { name, lastname1, lastname2, email, role } = payload
        if (!name || !lastname1 || !lastname2 || !email || !role) throw Error('Missing fields')
        if (!validateEmail(payload.email)) throw Error('Invalid email')
        if (payload.phone_number && !validatePhoneNumber(payload.phone_number)) throw Error('Invalid phone number')
        if (payload.extension_number && !validateExtensionNumber(payload.extension_number)) throw Error('Invalid extension number')
        if (!Object.values(Role).includes(payload.role)) throw Error('Invalid role')
        if (await this.userRepository.existsByEmail(payload.email)) throw Error('Already exists')
        const password = createPassword(name, lastname1, lastname2)
        payload.password = await encodeString(password!)
        return this.userRepository.save(payload)
    }
}