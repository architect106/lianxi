package com.kaika.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kaika.mapper.AreaMapper;
import com.kaika.model.Area;
import com.kaika.service.AreaService;


@Service
public class AreaServiceImp implements AreaService{

	private AreaMapper areaMapper;
	
	@Autowired 
	public AreaServiceImp(AreaMapper areaMapper) {
		this.areaMapper = areaMapper;
	}

	@Override
	public List<Area> listArea(Area area) {
		return areaMapper.listByCondition(area);
	}

	@Override
	public int count(Area area) {
		return areaMapper.count(area);
	}

	@Override
	public void saveAreaInfo(Area area) {
		areaMapper.insertSelective(area);
	}

	@Override
	public int updateAreaInfo(Area area) {
		return areaMapper.updateByPrimaryKeySelective(area);
	}	

	@Override
	public int deleteArea(Integer uid) {
		return areaMapper.deleteByPrimaryKey(uid);
	}	

}	

