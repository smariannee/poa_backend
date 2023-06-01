import {Area} from "../../entities/area";
import {SaveAreaDto, UpdateAreaDto, UpdateStatusAreaDto} from "../../entities/areaDto";


export interface AreaRepository {

    findAll(): Promise<Area[]>
    findById(id: number): Promise<Area>;
    create(user: SaveAreaDto): Promise<Area>;
    update(user: UpdateAreaDto): Promise<Area>;
    updateStatus(user:UpdateStatusAreaDto): Promise<Area>;
    existByName(name: string): Promise<boolean>;


}