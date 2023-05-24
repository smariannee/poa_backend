import {UseCase} from "../../../kernel/contracts";
import {GetUserDto, SaveUserDto, UpdateUserDto} from "../adapters/userDTO";
import {User} from "../entities/user";
import {UserRepository} from "./ports/user.repository";


export class GetAllUsersInteractor implements UseCase<GetUserDto, User[]> {
    constructor(private readonly userRepository: UserRepository) {
    }
    execute(): Promise<User[]> {
        return this.userRepository.findAll()
    }
}

export class GetUserInteractor implements UseCase<number, User> {
    constructor(private readonly userRepository: UserRepository) {
    }
    execute(id: number): Promise<User> {
        return this.userRepository.findById(id);
    }
}

export class SaveUserInteractor implements UseCase<SaveUserDto, User> {
    constructor(private readonly userRepository: UserRepository) {
    }
    async execute(payload: SaveUserDto): Promise<User> {
        return this.userRepository.create(payload)
    }
}

export class UpdateUserInteractor implements UseCase<UpdateUserDto, User> {
    constructor(private readonly userRepository: UserRepository) {
    }

    execute(payload: UpdateUserDto): Promise<User> {
        return this.userRepository.update(payload)
    }
}

export class UpdateStatusUserInteractor implements UseCase<number, User> {
    constructor(private readonly userRepository: UserRepository) {
    }
    execute(id: number): Promise<User> {
        return this.userRepository.updateStatus(id);
    }
}
