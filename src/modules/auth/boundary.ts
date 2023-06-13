import {GetUserDto} from "../users/adapters/dto";
import {UserStorageGateway} from "@/modules/users/adapters/user.storage.gateway";

const UserStorage = new UserStorageGateway()

// data shared between modules
export type User = GetUserDto;

// const findByEmail = UserStorage.findByEmail;