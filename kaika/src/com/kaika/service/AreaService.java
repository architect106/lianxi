package com.kaika.service;

import java.util.List;
import com.kaika.model.Area;

public interface AreaService {  

	List<Area> listArea(Area area);

	int count(Area area);

	void saveAreaInfo(Area area);

	int updateAreaInfo(Area area);

	int deleteArea(Integer uid);

}
