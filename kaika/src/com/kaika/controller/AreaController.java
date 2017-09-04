package com.kaika.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kaika.model.Area;
import com.kaika.service.AreaService;
import com.kaika.util.JSONUtil;


@Controller
@RequestMapping("/area")
public class AreaController{

	@Autowired
	private AreaService areaService;
	
	
	//listArea
	@RequestMapping("/listArea")
	@ResponseBody
	public String listArea(Area area, Model model){
		List<Area> areas = areaService.listArea(area);
		return JSONUtil.getOptions(areas);
	}
	
	//toHandleAreaInfo
	@RequestMapping("/toHandleAreaInfo")
	public String toHandleAreaInfo(Area area, Model model) {
		if(area.getId()!=null){
			area = areaService.listArea(area).get(0);
			model.addAttribute("area", area);
		}
		return "area/areaInfo";
	}
	
	//handleAreaInfo
	@RequestMapping("/handleAreaInfo")
	public String handleAreaInfo(Area area, Model model, HttpServletRequest request) {
		if(area.getId()!=null){
			int status =  areaService.updateAreaInfo(area);
			if(status<0){
				request.setAttribute("msg", "Update fail.");
				return "index/error";
			}
		}else{
			areaService.saveAreaInfo(area);
		}
		return "redirect:/area/listArea";
	}
	
	
	//deleteArea
	@RequestMapping("/deleteArea")
	public String deleteArea(Integer id, HttpServletRequest request){
		int status = areaService.deleteArea(id);
		if(status<0){
			request.setAttribute("msg", "Delete fail.");
			return "area/error";
		}
		return "redirect:/area/listArea";
	}
	
	
}
