package com.kaika.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kaika.model.Card;
import com.kaika.model.CardVO;
import com.kaika.service.CardService;
import com.kaika.util.JSONUtil;


/**
 * 分页暂时有问题，不能获取前台分页参数page rows
 * @author liuya
 *
 */
@Controller
@RequestMapping("/card")
public class CardController{

	@Autowired
	private CardService cardService;
	
	//toListCard
	@RequestMapping("/toListCard")
	public String toListCard(){
		return "card/listCard";
	}
	
	//listCard
	@RequestMapping("/listCard")
	@ResponseBody
	public String listCard(CardVO card, Model model, HttpServletRequest request){
		card = checkData(card);
		card.setDeleted(1);
		List<Card> cards = cardService.listCard(card);
		int total = cardService.count(card);
		return JSONUtil.getPageData(cards, total);
	}
	
	//checkData
	private CardVO checkData(CardVO card) {
		//开始结束日期
		String startTime = card.getStartTime();
		String endTime = card.getEndTime();
		if(startTime!=null && endTime!=null && !"".equals(startTime) && !"".equals(endTime)){
			startTime += " 00:00:00";
			endTime += " 23:59:59";
		}else{
			startTime = null;
			endTime = null;
		}
		card.setStartTime(startTime);
		card.setEndTime(endTime);
		//卡号
		String number = card.getNumber();
		if("".equals(number)){
			number = null;
		}
		card.setNumber(number);
		//手机
		String mobile = card.getMobile();
		if("".equals(mobile)){
			mobile = null;
		}
		card.setMobile(mobile);
		//激活状态
		Integer status = card.getStatus();
		if("".equals(status)){
			status = null;
		}
		card.setStatus(status);
		return card;
	}

	//toHandleCardInfo
	@RequestMapping("/toHandleCardInfo")
	public String toHandleCardInfo(CardVO card, Model model) {
		if(card.getId()!=null){
			Card dbCard = cardService.listCard(card).get(0);
			model.addAttribute("card", dbCard);
		 }
		return "card/cardInfo";
	}
	
	//handleCardInfo
	@RequestMapping("/handleCardInfo")
	@ResponseBody
	public String handleCardInfo(Card card, Model model, HttpServletRequest request) {
		Date date = new Date();
		if(card.getId()!=null){
			card.setEditTime(date);
			if(card.getDeleted()!=null){
				//逻辑删除
				boolean status = cardService.updateCardInfo(card);
				if(status){
					return JSONUtil.getMessage(true, "删除数据成功...");
				}
				return JSONUtil.getMessage(false, "删除数据失败...");
			}else{
				//更新
				boolean status = cardService.updateCardInfo(card);
				if(status){
					return JSONUtil.getMessage(true, "更新数据成功...");
				}
				return JSONUtil.getMessage(false, "更新数据失败...");
			}
		}else{
			//判断是否存在相同卡号
			CardVO cv = new CardVO();
			cv.setNumber(card.getNumber());
			List<Card> cards = cardService.listCard(cv);
			Card dbCard = null;
			if(cards.size()>0){
				dbCard = cards.get(0);
			}
			//新增
			if(dbCard==null){
				card.setCreateTime(date);
				boolean status = cardService.saveCardInfo(card);
				if(status){
					return JSONUtil.getMessage(true, "新增数据成功...");
				}
				return JSONUtil.getMessage(false, "新增数据失败...");
			}else{
				return JSONUtil.getMessage(false, "卡号重复...");
			}
		}
	}
	
	//deleteCard
	@RequestMapping("/deleteCard")
	public String deleteCard(Integer id, HttpServletRequest request){
		boolean status = cardService.deleteCard(id);
		if(status){
			return JSONUtil.getMessage(true, "删除数据成功...");
		}
		return JSONUtil.getMessage(false, "删除数据失败...");
	}
	
	//toImportExcel
	@RequestMapping("/toImportExcel")
	public String toImportExcel(){
		return "card/import";
	}
	
	//importExcel
	@RequestMapping("/importExcel.do")
	public String importExcel(
			@RequestParam(value="cardExcel",required=false)MultipartFile mf,
			HttpServletRequest request){
		//上传文件
		String path = request.getServletContext().getRealPath("/upload");
		String name = mf.getOriginalFilename();
		File file = new File(path,name);
		try {
			mf.transferTo(file);
		}  catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
		//读取excel
		List<Card> cards = read2003Excel(file);
		//插入数据库 分割LIST500条 调用批量插入数据
		int size = cards.size()/500 + 1;
		for(int i=0; i<size; i++){
			List<Card> partCrads = new ArrayList<Card>();
			if(i==size-1){
				for(int j=0;j<cards.size()%500;j++){
					int index = i*500 + j;
					partCrads.add(cards.get(index));
				}
			}else{
				for(int j=0;j<500;j++){
					int index = i*500 + j;
					partCrads.add(cards.get(index));
				}
			}
			cardService.saveCardsBatch(partCrads);
		}
		return null;
	}
	
	@SuppressWarnings("deprecation")
	private List<Card> read2003Excel(File excel) {
		List<Card> cards = new ArrayList<Card>();
		try {
			@SuppressWarnings("resource")
			HSSFWorkbook hwb = new HSSFWorkbook(new FileInputStream(excel));
			HSSFSheet sheet = hwb.getSheetAt(0); 
			HSSFRow row = null;  
			for (int i = sheet.getFirstRowNum() + 1 ; 
					i < sheet.getPhysicalNumberOfRows(); i++) { 
				row = sheet.getRow(i);
				//组装数据
				Card card = new Card();
                card.setNumber(row.getCell(0).getStringCellValue());  
                row.getCell(1).setCellType(Cell.CELL_TYPE_STRING); //设置表格数据类型
                card.setPassword(row.getCell(1).getStringCellValue());
                cards.add(card);
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return cards;
	}

	//exportExcel
    @RequestMapping("/exportExcel" )
	public String exportExcel(CardVO card, HttpServletRequest request,
							HttpServletResponse response) throws FileNotFoundException, IOException {
    	//获取数据
    	card = checkData(card);
		card.setDeleted(1);
		List<Card> cards = cardService.listCard(card);
		
    	//创建excel
		String upload = request.getServletContext().getRealPath("/upload");
		String name = "card.xls";
		String path = upload + File.separator + name;
		creat2003Excel(path, cards);
		
		//下载
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition", "attachment;fileName=" + name);
		InputStream is = null;
		OutputStream os = null;
		try {
			is = new FileInputStream(path);
			os = response.getOutputStream();
			byte[] b = new byte[2048];
			int length;
			while ((length = is.read(b)) > 0) {
				os.write(b, 0, length);
			}
			os.flush();
			os.close();
			is.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	private void creat2003Excel(String path, List<Card> cards) {
		@SuppressWarnings("resource")
		HSSFWorkbook workBook = new HSSFWorkbook();// 创建 一个excel文档对象  
		  
        HSSFSheet sheet = workBook.createSheet();// 创建一个工作薄对象  
        
        //设置单元格宽度自适应
        sheet.setColumnWidth(10,12*256);
        sheet.setColumnWidth(14,21*256);
        sheet.setColumnWidth(16,21*256);  
        sheet.setColumnWidth(17,21*256);  
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        
        //设置表头
        HSSFRow head = sheet.createRow(0);
        head.createCell(0).setCellValue("编号");
        head.createCell(1).setCellValue("卡号");
        head.createCell(2).setCellValue("密码");
        head.createCell(3).setCellValue("激活状态");
        head.createCell(4).setCellValue("定期");
        head.createCell(5).setCellValue("名字");
        head.createCell(6).setCellValue("学校");
        head.createCell(7).setCellValue("手机");
        head.createCell(8).setCellValue("邮编");
        head.createCell(9).setCellValue("区域");
        head.createCell(10).setCellValue("街道");
        head.createCell(11).setCellValue("道路");
        head.createCell(12).setCellValue("门牌号");
        head.createCell(13).setCellValue("房间号");
        head.createCell(14).setCellValue("激活日期");
        head.createCell(15).setCellValue("杂志名");
        head.createCell(16).setCellValue("创建日期");
        head.createCell(17).setCellValue("编辑日期");
        head.createCell(18).setCellValue("标记");
        head.createCell(19).setCellValue("是否删除");
        
        for(int i=1; i<=cards.size(); i++){
        	Card card = cards.get(i-1);
        	HSSFRow row = sheet.createRow(i);// 创建一个行对象  
        	row.createCell(0).setCellValue(card.getId());
        	row.createCell(1).setCellValue(card.getNumber());
        	row.createCell(2).setCellValue(card.getPassword());
        	int status = card.getStatus();
        	if(status==0){
        		row.createCell(3).setCellValue("未激活");
        	}
        	if(status==1){
        		row.createCell(3).setCellValue("已激活");
        	}
        	String orderDate = card.getOrderDate();
        	if(orderDate!=null){
        		row.createCell(4).setCellValue(orderDate);
        	}else{
        		row.createCell(4).setCellValue("");
        	}
        	String name = card.getName();
        	if(name!=null){
        		row.createCell(5).setCellValue(name);
        	}else{
        		row.createCell(5).setCellValue("");
        	}
        	String school = card.getSchool();
        	if(school!=null){
        		row.createCell(6).setCellValue(school);
        	}else{
        		row.createCell(6).setCellValue("");
        	}
        	String mobile = card.getMobile();
        	if(mobile!=null){
        		row.createCell(7).setCellValue(mobile);
        	}else{
        		row.createCell(7).setCellValue("");
        	}
        	Integer zipcode = card.getZipcode();
        	if(zipcode!=null){
        		row.createCell(8).setCellValue(zipcode);
        	}else{
        		row.createCell(8).setCellValue("");
        	}
        	String regionName = card.getRegionName();
        	if(regionName!=null){
        		row.createCell(9).setCellValue(regionName);
        	}else{
        		row.createCell(9).setCellValue("");
        	}
        	String streetName = card.getStreetName();
        	if(streetName!=null){
        		row.createCell(10).setCellValue(streetName);
        	}else{
        		row.createCell(10).setCellValue("");
        	}
        	String road = card.getRoad();
        	if(road!=null){
        		row.createCell(11).setCellValue(road);
        	}else{
        		row.createCell(11).setCellValue("");
        	}
        	String doorplate = card.getDoorplate();
        	if(doorplate!=null){
        		row.createCell(12).setCellValue(doorplate);
        	}else{
        		row.createCell(12).setCellValue("");
        	}
        	String room = card.getRoom();
        	if(room!=null){
        		row.createCell(13).setCellValue(room);
        	}else{
        		row.createCell(13).setCellValue("");
        	}
        	Date activationTime = card.getActivationTime();
        	if(activationTime!=null){
        		row.createCell(14).setCellValue(sdf.format(activationTime));
        	}else{
        		row.createCell(14).setCellValue("");
        	}
        	String jouranl = card.getJouranl();
        	if(jouranl!=null){
        		row.createCell(15).setCellValue(jouranl);
        	}else{
        		row.createCell(15).setCellValue("");
        	}
        	Date createTime = card.getCreateTime();
        	if(createTime!=null){
        		row.createCell(16).setCellValue(sdf.format(createTime));
        	}else{
        		row.createCell(16).setCellValue("");
        	}
        	Date editTime = card.getEditTime();
        	if(editTime!=null){
        		row.createCell(17).setCellValue(sdf.format(editTime));
        	}else{
        		row.createCell(17).setCellValue("");
        	}
        	String remark = card.getRemark();
        	if(remark!=null){
        		row.createCell(18).setCellValue(remark);
        	}else{
        		row.createCell(18).setCellValue("");
        	}
        	int deleted = card.getDeleted();
        	if(deleted==0){
        		row.createCell(19).setCellValue("已删除");
        	}
        	if(deleted==1){
        		row.createCell(19).setCellValue("未删除");
        	}
        }
        
        try {
			FileOutputStream os = new FileOutputStream(path);
			workBook.write(os);// 将文档对象写入文件输出流  
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}  
        
        
	}
	
}
