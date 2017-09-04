package com.kaika.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kaika.model.Journal;
import com.kaika.service.JournalService;
import com.kaika.util.JSONUtil;


@Controller
@RequestMapping("/journal")
public class JournalController{

	@Autowired
	private JournalService journalService;
	
	//toListJournal
	@RequestMapping("/toListJournal")
	public String toListJournal(){
		return "journal/listJournal";
	}
	
	//listJournal
	@RequestMapping("/listJournal")
	@ResponseBody
	public String listJournal(Journal journal, Model model){
		journal.setDeleted(0);
		List<Journal> journals = journalService.listJournal(journal);
		return JSONUtil.getAllData(journals);
	}
	
	//toPreviewJournalInfo
	@RequestMapping("/toPreviewJournalInfo")
	public String toPreviewJournalInfo(Journal journal, Model model) {
		if(journal.getId()!=null){
			journal = journalService.listJournal(journal).get(0);
			model.addAttribute("journal", journal);
		}
		return "journal/preview";
	}
	
	//toHandleJournalInfo
	@RequestMapping("/toHandleJournalInfo")
	public String toHandleJournalInfo(Journal journal, Model model) {
		if(journal.getId()!=null){
			journal = journalService.listJournal(journal).get(0);
			model.addAttribute("journal", journal);
		}
		return "journal/journalInfo";
	}
	
	//handleJournalInfo
	@RequestMapping("/handleJournalInfo")
	@ResponseBody
	public String handleJournalInfo(Journal journal, Model model, 
			@RequestParam(value="imageFile",required=false)MultipartFile mf,
			HttpServletRequest request) {
		//上传文件
		String name = null;
		if(mf!=null){
			String path = "C:/tomcat/apache-tomcat-8.0.43/webapps/images";
			name = mf.getOriginalFilename();
			File file = new File(path,name);
			try {
				mf.transferTo(file);
			}  catch (Exception e) {
				throw new RuntimeException(e.getMessage());
			}
		}
		
		//设置journal对象图片相对路径
		if(name!=null){
			name = "images" + File.separator + name;
		}
		journal.setImage(name);
		
		if(journal.getId()!=null){
			//更新
			boolean status = journalService.updateJournalInfo(journal);
			if(status){
				return JSONUtil.getMessage(true, "更新数据成功...");
			}
			return JSONUtil.getMessage(false, "更新数据失败...");
		}else{
			//新增
			journal.setDeleted(1);
			boolean status = journalService.saveJournalInfo(journal);
			if(status){
				return JSONUtil.getMessage(true, "新增数据成功...");
			}
			return JSONUtil.getMessage(false, "新增数据失败...");
		}
	}
	
	//updateJournalStatus
	@RequestMapping("/updateJournalStatus")
	@ResponseBody
	public String updateJournalStatus(Journal journal, Model model){
		if(journal.getDeleted()!=null){
			if(journal.getDeleted()==0){
				//逻辑删除
				boolean status = journalService.updateJournalInfo(journal);
				if(status){
					return JSONUtil.getMessage(true, "删除数据成功...");
				}
				return JSONUtil.getMessage(false, "删除数据失败...");
			}
			if(journal.getDeleted()==2){
				//杂志设置
				boolean status = journalService.updateUseStatus(journal);
				if(status){
					return JSONUtil.getMessage(true, "杂志设置成功...");
				}
				return JSONUtil.getMessage(false, "杂志设置失败...");
			}
			return null;
		}else{
			return JSONUtil.getMessage(false, "杂志设置失败...");
		}
	}
	
	
}
