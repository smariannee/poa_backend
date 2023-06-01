import {UseCase} from "../../../kernel/contracts";
import {UpdateStatusAreaDto} from "../entities/areaDto";
import {Area} from "../entities/area";
import {AreaRepository} from "./ports/area.repository";

export class UpdateStatusAreaInteractor implements UseCase<UpdateStatusAreaDto, Area> {
    constructor(private readonly areaRepository: AreaRepository) {
    }
    execute(user:UpdateStatusAreaDto): Promise<Area> {
        return this.areaRepository.updateStatus(user);
    }
}
