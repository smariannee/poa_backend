import { UseCase } from "@/kernel/contracts"
import { validateEmail, validateExtensionNumber, validatePassword, validatePhoneNumber } from "../../../utils/validations"
import { SaveUserDto } from "../adapters/dto"
import { Role } from "../entities/role"
import { User } from "../entities/user"
import { UserRepository } from "./ports/user.repository"

export class SaveUserInteractor implements UseCase<SaveUserDto, User> {
    constructor(private readonly userRepository: UserRepository) {}
    async execute(payload: SaveUserDto): Promise<User> {
        if (!payload.name || !payload.lastname1 || !payload.lastname2 || !payload.email || !payload.password || !payload.role) throw Error('Missing fields')
        if (!validateEmail(payload.email)) throw Error('Invalid email')
        if (!validatePassword(payload.password)) throw Error('Invalid password')
        if (payload.phone_number && !validatePhoneNumber(payload.phone_number)) throw Error('Invalid phone number')
        if (payload.extension_number && !validateExtensionNumber(payload.extension_number)) throw Error('Invalid extension number')
        if (!Object.values(Role).includes(payload.role)) throw Error('Invalid role')
        if (await this.userRepository.existsByEmail(payload.email)) throw Error('Already exists')
        return this.userRepository.save(payload)
    }
}