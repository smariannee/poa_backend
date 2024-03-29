import { UseCase } from "@/kernel/contracts";
import { UpdateUserDto } from "../adapters/dto";
import { Role } from "../entities/role";
import { User } from "../entities/user";
import { UserRepository } from "./ports/user.repository";
import { validateEmail, validateExtensionNumber, validatePhoneNumber } from "../../../utils/validations"

export class UpdateUserInteractor implements UseCase<UpdateUserDto, User> {
    constructor(private readonly userRepository: UserRepository) {}
    async execute(payload: UpdateUserDto): Promise<User> {
        if (!payload.id) throw Error('Missing id')
        if (!payload.name || !payload.lastname1 || !payload.lastname2 || !payload.email || !payload.role) throw Error('Missing fields')
        if (!validateEmail(payload.email)) throw Error('Invalid email')
        if (payload.phone_number && !validatePhoneNumber(payload.phone_number)) throw Error('Invalid phone number')
        if (payload.extension_number && !validateExtensionNumber(payload.extension_number)) throw Error('Invalid extension number')
        if (await this.userRepository.existsById(payload.id)) {
            const user = await this.userRepository.findById(payload.id)
            if (user.role != payload.role) {
                if (!user.availability) throw Error('User occupied')
            }
        } else {
            throw Error('Not found')
        }
        return this.userRepository.update(payload)
    }
}